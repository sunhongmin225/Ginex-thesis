import argparse
import time
import os
import glob
from datetime import datetime
import torch
import torch.nn.functional as F
from tqdm import tqdm
import threading
from queue import Queue
from sage import SAGE

from lib.data import *
from lib.cache import *
from lib.utils import *
from lib.neighbor_sampler import GinexNeighborSampler

exp_name = '2022_10_08_11_20_09'
khop = 5
trace_load_num_threads = 4
num_iter = 6600
i = 1

def trace_load(q, indices, sb, khop):
    for i in indices:
        if khop > 1 and i % khop == 0:
            q.put((
                torch.load('./trace/' + exp_name + '/' + 'sb_' + str(sb) + '_ids_' + str(i) + '.pth'),
                torch.load('./trace/' + exp_name + '/' + 'sb_' + str(sb) + '_adjs_' + str(i) + '.pth'),
                torch.load('./trace/' + exp_name + '/' + 'sb_' + str(sb) + '_update_' + str(i) + '.pth'),
                ))
        else:
            q.put((
                torch.load('./trace/' + exp_name + '/' + 'sb_' + str(sb) + '_ids_' + str(i) + '.pth'),
                torch.load('./trace/' + exp_name + '/' + 'sb_' + str(sb) + '_adjs_' + str(i) + '.pth'),
                ))


q = list()
loader = list()
for t in range(trace_load_num_threads):
    q.append(Queue(maxsize=2))
    loader.append(threading.Thread(target=trace_load, args=(q[t], list(range(t, num_iter, trace_load_num_threads)), i-1, khop), daemon=True))
    loader[t].start()

import pdb; pdb.set_trace()

n_id_q = Queue(maxsize=2)
adjs_q = Queue(maxsize=2)
in_indices_q = Queue(maxsize=2)
in_positions_q = Queue(maxsize=2)
out_indices_q = Queue(maxsize=2)

q_value_0 = q[0].get()
print('len(q_value_0) :', len(q_value_0))
q_value_1 = q[1].get()
print('len(q_value_1) :', len(q_value_1))

if q_value_1:
    n_id, adjs = q_value_1
    batch_size = adjs[-1].size[1]
    n_id_q.put(n_id)
    adjs_q.put(adjs)

import pdb; pdb.set_trace()

if q_value_0:
    n_id, adjs, (in_indices, in_positions, out_indices) = q_value_0
    batch_size = adjs[-1].size[1]
    n_id_q.put(n_id)
    adjs_q.put(adjs)
    in_indices_q.put(in_indices)
    in_positions_q.put(in_positions)
    out_indices_q.put(out_indices)

import pdb; pdb.set_trace()
