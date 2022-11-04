import torch
from lib.neighbor_sampler import *
from lib.utils import *
import threading
from queue import Queue
import numpy as np
import json
import os
from tqdm import tqdm
import time
import math


def save(i, in_indices, in_indices_, out_indices, exp_name, sb):
    path = './trace/' + exp_name + '/sb_' + str(sb) + '_update_' + str(i) + '.pth'
    torch.save((in_indices.cpu(), in_indices_.cpu(), out_indices.cpu()), path)


def load(n_id_list, indices, exp_name, sb):
    for i in indices:
        n_id = torch.load('./trace/' + exp_name + '/sb_' + str(sb) + '_ids_' + str(i) + '.pth')
        n_id_list[i] = n_id


def load_into_queue(q, indices, exp_name, sb):
    for i in indices:
        q.put(torch.load('./trace/' + exp_name + '/sb_' + str(sb) + '_ids_' + str(i) + '.pth'))


def send(q, n_id_list, indices):
    for i in indices:
        q.put(n_id_list[i].to('cuda', non_blocking=True))


class FeatureCache:
    '''
    Feature cache of Ginex

    Args:
        size (int): the size of the feature cache including both the cached data and 
            the address table in byte.
        effective_sb_size (int): the number of iterations to precompute the changeset.
            It is usually same as the superbatch size except the last superbatch of 
            each epoch.
        num_nodes (int): the number of nodes in the graph.
        mmapped_features (Tensor): the tensor memory-mapped to the feature vectors
        feature_dim (int): the dimension of the feature vectors
        exp_name (str): the name of the experiments used to designate the path of the
            runtime trace files.
        sb (int): the superbatch number
        verbose (bool): if set, the detailed processing information is displayed

    '''
    def __init__(self, size, effective_sb_size, khop, num_nodes, mmapped_features,
            feature_dim, exp_name, sb, verbose):
        
        self.size = size
        self.effective_sb_size = effective_sb_size
        self.khop = khop
        # The current implementation use int16 for 'iters' which limits the number of 
        # iterations to perform cache state simulation.
        if self.effective_sb_size > torch.iinfo(torch.int16).max:
            raise ValueError
        self.num_nodes = num_nodes
        self.mmapped_features = mmapped_features
        self.feature_dim = feature_dim
        self.exp_name = exp_name
        self.sb = sb
        self.verbose = verbose

        # The address table of the cache has num_nodes entries each of which is a single
        # int32 value. This can support the cache with up to 2147483647 entries.
        table_size = 4 * self.num_nodes
        self.num_entries = int((self.size-table_size)/4/self.feature_dim)
        if self.num_entries > torch.iinfo(torch.int32).max:
            raise ValueError


    # Fill cache with the feature vectors corresponding to the given indices. It is called
    # when initializing the feature cache in order to reduce the cold misses. 
    def fill_cache(self, indices):
        self.address_table = torch.full((self.num_nodes,), -1, dtype=torch.int32)
        self.address_table[indices] = torch.arange(indices.numel(), dtype=torch.int32)
        orig_num_threads = torch.get_num_threads() 
        torch.set_num_threads(int(os.environ['GINEX_NUM_THREADS']))
        self.cache = self.mmapped_features[indices]
        torch.set_num_threads(orig_num_threads) 


    # Two passes over ids files to construct data structures for cache state simulation and
    # figure out the initial cache indices.
    def pass_1_and_2(self):
        start = time.time()

        if self.verbose:
            tqdm.write('Loading ids...')
        num_threads = 16
        n_id_list = [[]] * self.effective_sb_size
        loader = list()
        for t in range(num_threads):
            loader.append(threading.Thread(target=load, args=( n_id_list, list(range(t, len(n_id_list), num_threads)), self.exp_name, self.sb ) ) )
            loader[t].start()
        for t in range(num_threads):
            loader[t].join()
        if self.verbose:
            tqdm.write('Done!')
        
        # Pass 1
        if self.verbose:
            tqdm.write('Pass 1: calculating frequency and initial cache indices...')
        frq = torch.zeros(self.num_nodes, dtype=torch.int16, device='cuda')
        filled=False
        count=0
        initial_cache_indices = torch.empty((0,), dtype=torch.int64, device='cuda')

        # Merge k n_ids for changeset precomputation
        if self.khop > 1:
            n_id_prime_list = [[]] * math.ceil(self.effective_sb_size / self.khop)
            idx_prime = 0
            for idx in range(0, len(n_id_list), self.khop):
                n_id_prime = n_id_list[idx].cuda()
                if idx <= len(n_id_list) - self.khop:
                    for i in range(idx + 1, idx + self.khop):
                        n_id_prime = torch.cat((n_id_prime, n_id_list[i].cuda())).unique()
                else:
                    for i in range(idx, len(n_id_list)):
                        n_id_prime = torch.cat((n_id_prime, n_id_list[i].cuda())).unique()
                n_id_prime_list[idx_prime] = n_id_prime
                idx_prime += 1
            n_id_list = n_id_prime_list

        for n_id in n_id_list:
            n_id = n_id.cuda()
            if not filled:
                to_cache = n_id[frq[n_id] == 0]
                count += to_cache.numel()
                if count >= self.num_entries:
                    to_cache = to_cache[:self.num_entries-(count-to_cache.numel())]
                    initial_cache_indices = torch.cat([initial_cache_indices, to_cache])
                    filled=True
                else:
                    initial_cache_indices = torch.cat([initial_cache_indices, to_cache])

            frq[n_id] += 1
        if self.verbose:
            tqdm.write('Done!')

        # Pass 2
        if self.verbose:
            tqdm.write('Pass 2: making two key data structures (iterptr & iters)...')
        msb = (torch.tensor([1], dtype=torch.int16) << 15).cuda()

        cumsum = frq.cumsum(dim=0)
        iterptr = torch.cat([torch.tensor([0,0], device='cuda'), cumsum[:-1]]); del(cumsum)
        frq_sum = frq.sum(); del(frq)

        iters = torch.zeros(frq_sum+1, dtype=torch.int16, device='cuda')
        iters[-1] = self.effective_sb_size

        for i, n_id in enumerate(n_id_list):
            n_id_cuda = n_id.cuda()
            tmp = iterptr[n_id_cuda+1]
            iters[tmp] = i; del(tmp)
            iterptr[n_id_cuda+1] += 1; del(n_id_cuda)

        iters[iterptr[1:]] |= msb
        iterptr = iterptr[:-1]
        iterptr[0] = 0

        del(n_id_list)
        if self.khop > 1:
            del(n_id_prime_list)

        if self.verbose:
            tqdm.write('Done!')

        end = time.time()
        print('pass_1_and_2 time =', end - start)

        return iterptr, iters, initial_cache_indices


    # The last pass over ids files to simulate the cache state.
    def pass_3(self, iterptr, iters, initial_cache_indices):
        start = time.time()

        if self.verbose:
            tqdm.write('Pass 3: Computing changesets...')

        # Two auxiliary data structures for efficient cache state simulation
        #
        # cache_table: a table recording each node's state which is updated every
        #   iteration of the simulation. It has entries as many as the total number 
        #   of the nodes in the graph. Specifically, the last three bits of each 
        #   entires are used.
        #   bit 0: set if the feature vector of the corresponindg node is in the  
        #   cache at the current iteration
        #   bit 1: set if the feature vector of the corresponding node is accessed  
        #   at the current interation
        #   bit 2: set if the node is selected to be kept in the cache for the next 
        #   iteration
        #   bit 3~7: don't care
        #
        # map_table: mapping table that directly maps relative indices of the feature 
        #   vectors in the batch inputs, which is the output of gather, to their 
        #   absolute indices

        cache_table = torch.zeros(self.num_nodes, dtype=torch.int8, device='cuda')
        cache_table[initial_cache_indices] += 1 # bit 0
        del(initial_cache_indices)
        map_table = torch.full((self.num_nodes,), -1, dtype=torch.int32, device='cuda')
        
        msb = (torch.tensor([1], dtype=torch.int16) << 15).cuda()

        save_p = None
        threshold = 0

        # Multi-threaded streaming of n_ids
        q = list()
        loader = list()
        num_threads = 16
        for t in range(num_threads):
            q.append(Queue(maxsize=2))
            loader.append(threading.Thread(target=load_into_queue, args=(q[t], list(range(t, self.effective_sb_size, num_threads)), self.exp_name, self.sb), daemon=True))
            loader[t].start()

        for idx in range(0, self.effective_sb_size, self.khop):
            # Get n_id from the queue and send n_id to GPU
            n_id_prime = q[idx % num_threads].get().cuda()

            # Merge k n_ids for changeset precomputation
            if self.khop > 1:
                if idx <= self.effective_sb_size - self.khop:
                    for i in range(idx + 1, idx + self.khop):
                        n_id_prime = torch.cat((n_id_prime, q[i % num_threads].get().cuda())).unique()
                else:
                    if idx != self.effective_sb_size - 1:
                        for i in range(idx + 1, self.effective_sb_size):
                            n_id_prime = torch.cat((n_id_prime, q[i % num_threads].get().cuda())).unique()

            n_id_cuda = n_id_prime.cuda()
            del(n_id_prime)

            # Map table update
            map_table[n_id_cuda] = torch.arange(n_id_cuda.numel(), dtype=torch.int32, device='cuda')
            
            # Update iterptr
            iterptr[n_id_cuda] += 1
            last_access = n_id_cuda[(iters[iterptr[n_id_cuda]] < 0)] # when msb is set
            iterptr[last_access] = iters.numel()-1
            del(last_access)

            # Get candidates
            # candidates = union(current cache indices, incoming indices)
            cache_table[n_id_cuda] += 2 # bit 1
            candidates = (cache_table > 0).nonzero().squeeze()
            del(n_id_cuda)

            # Get next access iterations of candidates
            next_access_iters = iters[iterptr[candidates]]
            next_access_iters.bitwise_and_(~msb)
            
            # Find num_entries elements in candidates with the smallest next access
            # iteration by incrementally tracking threshold
            count = (next_access_iters <= threshold).sum()
            prev_status = (count >= self.num_entries)

            if prev_status:
                # Current threshold is high
                threshold -= 1
            else:
                # Current threshold is low
                threshold += 1
            while (True):
                if threshold > self.effective_sb_size:
                    num_remains = 0
                    break

                count = (next_access_iters <= threshold).sum()
                curr_status = (count >= self.num_entries)
                if (prev_status ^ curr_status):
                    if curr_status:
                        num_remains = self.num_entries - (next_access_iters <= (threshold-1)).sum()
                        threshold -= 1
                    else:
                        num_remains = self.num_entries - count
                    break
                elif (curr_status): threshold -= 1
                else: threshold += 1
            
            cache_table[candidates[next_access_iters <= threshold]] |= 4 # bit 2
            cache_table[candidates[next_access_iters == (threshold+1)][:num_remains]] |= 4 # bit 2
            del(candidates)
            del(next_access_iters)
           
            # in_indices: indices to newly insert into cache
            # in_positions: relative positions of nodes in in_indices within batch input
            # out_indices: indices to evict from cache
            in_indices = (cache_table == 2+4).nonzero().squeeze() # bit 1, 2
            in_positions = map_table[in_indices]
            out_indices = ((cache_table == 1) | (cache_table == 3)).nonzero().squeeze() # bit 0 || bit 0, 1

            # Configure cache table & map table for the next iteration
            cache_table >>= 2
            map_table[:] = -1

            # Multi-threaded save of changeset precomputation result
            save_p = threading.Thread(target=save, args=(idx, in_indices, in_positions, out_indices, self.exp_name, self.sb))
            save_p.start()
            
            del(in_indices); del(out_indices); del(in_positions);

            #####################################################################

        del(cache_table)
        del(iterptr)
        del(iters)
        del(map_table)

        if self.verbose:
            tqdm.write('Done!')

        end = time.time()
        print('pass_3 time =', end - start)

        return


    def update(self, batch_inputs, in_indices, in_positions, out_indices):
        cache_update(self, batch_inputs, in_indices, in_positions, out_indices)


    def update_khop(self, batch_inputs_list, in_indices, in_positions, out_indices, idx):
        cache_update_khop(self, batch_inputs_list, in_indices, in_positions, out_indices, idx)


class NeighborCache:
    '''
    Neighbor cache of Ginex

    Args:
        size (int): the size of the neighbor cache including both the cached data and 
            the address table in byte.
        score (Tensor): the score of each node defined as the ratio between the number 
            of out-neighbors and in-neighbors.
        indptr (Tensor): the indptr tensor.
        indices (Tensor): the (memory-mapped) indices tensor.
        num_nodes (int): the number of nodes in the graph.
    '''
    def __init__(self, size, score, indptr, indices, num_nodes, metadata_filename, cache_filename, cache_tbl_filename):
        self.size = size
        self.indptr = indptr
        self.indices = indices
        self.num_nodes = num_nodes
        self.metadata_filename = metadata_filename
        self.cache_filename = cache_filename
        self.cache_tbl_filename = cache_tbl_filename

        self.cache, self.address_table, self.num_entries = self.init_by_score(score)


    def init_by_score(self, score):
        sorted_indices = score.argsort(descending=True)
        neighbor_counts = self.indptr[1:] - self.indptr[:-1]
        neighbor_counts = neighbor_counts[sorted_indices]

        ginex_table_size = self.num_nodes*8
        # ginex_table_size = self.num_nodes*4
        cache_size = int((self.size - ginex_table_size)/8)
        # cache_size = int((self.size - ginex_table_size)/4)
        if cache_size < 0:
            raise ValueError

        ginex_address_table = torch.full((self.num_nodes,), -1, dtype=torch.int64)
        # ginex_address_table = torch.full((self.num_nodes,), -1, dtype=torch.int32)

        # Fetch neighborhood information of nodes into the cache one by one in order
        # of score until the cache gets full
        cumulative_size = torch.cumsum(neighbor_counts+1, dim=0)
        num_entries = (cumulative_size <= cache_size).sum().item()
        # sorted_indices = sorted_indices.to(torch.int32)
        # import pdb; pdb.set_trace()
        ginex_address_table[sorted_indices[:num_entries]] = torch.cat([torch.zeros(1).long(), cumulative_size[:num_entries-1]])
        # ginex_address_table[sorted_indices[:num_entries]] = torch.cat([torch.zeros(1).int(), cumulative_size[:num_entries-1]]).to(torch.int32)
        cached_idx = (ginex_address_table >= 0).nonzero().squeeze()

        # Multi-threaded load of neighborhood information
        ginex_cache = torch.zeros(cache_size, dtype=torch.int64)
        # cache = torch.zeros(cache_size, dtype=torch.int32)
        # import pdb; pdb.set_trace()
        # fill_neighbor_cache(cache, self.indptr.to(torch.int32), self.indices, cached_idx.to(torch.int32), ginex_address_table, num_entries)
        fill_neighbor_cache(ginex_cache, self.indptr, self.indices, cached_idx, ginex_address_table, num_entries)
        # import pdb; pdb.set_trace()
        compress_neighbor_cache(ginex_cache, ginex_address_table, self.num_nodes, self.metadata_filename, self.cache_filename, self.cache_tbl_filename)
        return ginex_cache, ginex_address_table, num_entries


    def save(self, data, filename):
        data_path = filename + '.dat'
        conf_path = filename + '_conf.json'

        data_mmap = np.memmap(data_path, mode='w+', shape=data.shape, dtype=data.dtype)
        data_mmap[:] = data[:]
        data_mmap.flush()

        mmap_config = dict()
        mmap_config['shape'] = tuple(data.shape)
        mmap_config['dtype'] = str(data.dtype)

        json.dump(mmap_config, open(conf_path, 'w'))
