import torch
import time
import argparse
import os
import json
import numpy as np

argparser = argparse.ArgumentParser()

argparser.add_argument('--dataset', type=str, default=None)

args = argparser.parse_args()

def get_score(csc_rowptr, csr_rowptr):
    print('start offline profiling (aligraph)...')

    num_nodes = csc_rowptr.numel() - 1
    eps = 0.00000001
    in_num_neighbor_list = (csc_rowptr[1:] - csc_rowptr[:-1]) + eps
    out_num_neighbor_list = (csr_rowptr[1:] - csr_rowptr[:-1]) + eps

    score = out_num_neighbor_list / in_num_neighbor_list

    return score

path = "./dataset/" + str(args.dataset)
print (path)
csc_indptr_path = os.path.join(path, 'indptr.dat')
csr_indptr_path = os.path.join(path, 'csr_indptr.dat')
conf_path = os.path.join(path, 'conf.json')
conf = json.load(open(conf_path, 'r'))

csc_indptr = torch.from_numpy(np.fromfile(csc_indptr_path, dtype=conf['indptr_dtype']).reshape(tuple(conf['indptr_shape'])) )
csr_indptr = torch.from_numpy(np.fromfile(csr_indptr_path, dtype=conf['indptr_dtype']).reshape(tuple(conf['indptr_shape'])) )
print ("finished loading")

start = time.time()
score = get_score(csc_indptr, csr_indptr)
end = time.time()
print (end-start)

torch.save(score, "./dataset/" + str(args.dataset) + "/nc_score" + ".pth")
