import argparse
import os
import math

from lib.data import *
from lib.cache import *


# Parse arguments
argparser = argparse.ArgumentParser()
argparser.add_argument('--dataset', type=str, default='ogbn-papers100M')
argparser.add_argument('--neigh-cache-size', type=int, default=45000000000)
argparser.add_argument('--ginex-num-threads', type=int, default=128)
argparser.add_argument('--zstd', dest='zstd', default=False, action='store_true')
args = argparser.parse_args()

# Set environment and path
os.environ['GINEX_NUM_THREADS'] = str(args.ginex_num_threads)
dataset_path = os.path.join('./dataset', args.dataset + '-ginex')
score_path = os.path.join(dataset_path, 'nc_score.pth')
split_idx_path = os.path.join(dataset_path, 'split_idx.pth')


def save_neighbor_cache():
    print('Creating and saving neighbor cache...')
    dataset = GinexDataset(path=dataset_path, split_idx_path=split_idx_path, score_path=score_path)
    score = dataset.get_score()
    rowptr, col = dataset.get_adj_mat()
    num_nodes = dataset.num_nodes

    if args.zstd:
        zstd_comp_ratio = 2.00
        nctbl_size_in_bytes = num_nodes * 2 * 8
        nc_size_in_bytes = math.floor((args.neigh_cache_size - nctbl_size_in_bytes) * zstd_comp_ratio) + num_nodes * 8
        metadata_filename = str(dataset_path) + '/zstd_metadata_size_' + str(args.neigh_cache_size) + '.txt'
        cache_filename = str(dataset_path) + '/nc_size_' + str(args.neigh_cache_size) + '.dat.zstd'
        cache_tbl_filename = str(dataset_path) + '/nctbl_size_' + str(args.neigh_cache_size) + '_zstd.dat'
        neighbor_cache = NeighborCache(nc_size_in_bytes, score, rowptr, dataset.indices_path, num_nodes, metadata_filename, cache_filename, cache_tbl_filename, args.zstd)
        del(score)
        print('Done!')

    else:
        neighbor_cache = NeighborCache(args.neigh_cache_size, score, rowptr, dataset.indices_path, num_nodes, None, None, None, args.zstd)
        del(score)
        print('Done!')

        print('Saving neighbor cache...')
        cache_filename = str(dataset_path) + '/nc_size_' + str(args.neigh_cache_size)
        cache_tbl_filename = str(dataset_path) + '/nctbl_size_' + str(args.neigh_cache_size)
        neighbor_cache.save(neighbor_cache.cache.numpy(), cache_filename)
        neighbor_cache.save(neighbor_cache.address_table.numpy(), cache_tbl_filename)
        print('Done!')


# Save neighbor cache
print('Save neighbor cache...')
save_neighbor_cache()
print('Done!')
