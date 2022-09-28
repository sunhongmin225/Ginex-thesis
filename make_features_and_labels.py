import numpy as np
import torch

num_nodes = 500000000
# num_features = 512
num_features = 256

features_shape = (num_nodes, num_features)
features_dtype = 'float32'
labels_shape = (num_nodes)
labels_dtype = 'float32'

features_mmap = np.memmap('features.dat', mode='w+', shape=features_shape, dtype=features_dtype)
labels_mmap = np.memmap('labels.dat', mode='w+', shape=labels_shape, dtype=labels_dtype)


chunk_size = 20000000
num_iter = int(num_nodes/chunk_size)+1

for i in range(num_iter):
    print (i)
    if i == (num_iter-1):
        features_mmap[i*chunk_size:] = np.random.rand(num_nodes-i*chunk_size, num_features)
    else:
        features_mmap[i*chunk_size:(i+1)*chunk_size] = np.random.rand(chunk_size, num_features)

features_mmap.flush()

for i in range(num_iter):
    print (i)
    if i == (num_iter-1):
        labels_mmap[i*chunk_size:] = np.random.rand(num_nodes-i*chunk_size)
    else:
        labels_mmap[i*chunk_size:(i+1)*chunk_size] = np.random.rand(chunk_size)

labels_mmap.flush()
