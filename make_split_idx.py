import argparse
import os
import json

from lib.data import *
from lib.cache import *

r_train = 0.1
r_valid = 0.05
r_test = 0.05

# Parse arguments
argparser = argparse.ArgumentParser()
argparser.add_argument('--dataset', type=str, default='ogbn-papers100M')
argparser.add_argument('--ginex-num-threads', type=int, default=128)
args = argparser.parse_args()

# Set environment and path
os.environ['GINEX_NUM_THREADS'] = str(args.ginex_num_threads)
dataset_path = os.path.join('./dataset', args.dataset + '-ginex')
split_idx_path = os.path.join(dataset_path, 'split_idx.pth')
conf_path = os.path.join(dataset_path, 'conf.json')
conf = json.load(open(conf_path, 'r'))
num_nodes = conf['num_nodes']

randperm = torch.randperm(num_nodes)

num_train = int(num_nodes * r_train)
num_valid = int(num_nodes * r_valid)
num_test = int(num_nodes * r_test)

train_idx = randperm[:num_train]
valid_idx = randperm[num_train:num_train+num_valid]
test_idx = randperm[num_train+num_valid:num_train+num_valid+num_test]

sorted_train_idx = train_idx.sort()[0]
sorted_valid_idx = valid_idx.sort()[0]
sorted_test_idx = test_idx.sort()[0]

split_idx = {}

split_idx['train'] = sorted_train_idx
split_idx['valid'] = sorted_valid_idx
split_idx['test'] = sorted_test_idx

torch.save(split_idx, split_idx_path)
