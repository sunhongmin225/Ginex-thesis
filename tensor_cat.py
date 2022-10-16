import torch
import numpy as np
import time
import math

# '''
tic = time.time()
n_id_list = [[]] * 100
k = 2
for i in range(len(n_id_list)):
	n_id_list[i] = torch.randint(0, 2000000000, (100000, 256))
prev = torch.tensor([])
print('create lists: ', time.time() - tic)

tic = time.time()
for i in range(0, len(n_id_list), k):
	# prev = torch.cat((prev, n_id_list[i]))
	# prev = torch.cat((prev, n_id_list[i+1]))
	prev = torch.cat((n_id_list[i], n_id_list[i+1]))
	prev = torch.tensor([])
print('\nopt1 torch.cat: ', time.time() - tic)
# '''

'''
tic = time.time()
device = torch.device('cuda:0')
torch.cuda.set_device(device)
n_id_list = [[]] * 100
k = 2
for i in range(len(n_id_list)):
	n_id_list[i] = torch.randint(0, 2000000000, (100000, 256))
prev = torch.tensor([], device=device)
print('create lists: ', time.time() - tic)

tic = time.time()
for i in range(0, len(n_id_list), k):
	prev = torch.cat((prev, n_id_list[i].to(device)))
	prev = torch.cat((prev, n_id_list[i+1].to(device)))
	prev = prev.to('cpu')
	prev = torch.tensor([], device=device)

print('\nopt2 torch.cat cuda: ', time.time() - tic)
'''

'''
tic = time.time()
n_id_prime_list = [[]] * math.ceil(len(n_id_list) / khop)
idx_prime = 0

for idx in range(0, len(n_id_list), khop):
	n_id_prime = n_id_list[idx]
	if idx <= len(n_id_list) - khop:
		for i in range(idx + 1, idx + khop):
			n_id_prime = torch.cat((n_id_prime, n_id_list[i]))
	else:
		for i in range(idx, len(n_id_list)):
			n_id_prime = torch.cat((n_id_prime, n_id_list[i]))
	n_id_prime = n_id_prime.unique()
	n_id_prime_list[idx_prime] = n_id_prime
	idx_prime += 1

print('\nopt1 torch.cat: ', time.time() - tic)

# import pdb; pdb.set_trace()
'''

'''
tic = time.time()
n_id_prime_list = [[]] * math.ceil(len(n_id_list) / khop)
idx_prime = 0

for idx in range(0, len(n_id_list), khop):
	n_id_prime = n_id_list[idx]
	if idx <= len(n_id_list) - khop:
		for i in range(idx + 1, idx + khop):
			n_id_prime = np.union1d(n_id_prime, n_id_list[i])
	else:
		for i in range(idx, len(n_id_list)):
			n_id_prime = np.union1d(n_id_prime, n_id_list[i])
	n_id_prime = torch.from_numpy(n_id_prime)
	n_id_prime_list[idx_prime] = n_id_prime
	idx_prime += 1

print('\nopt2 np.union1d: ', time.time() - tic)

# import pdb; pdb.set_trace()
'''

'''
tic = time.time()
n_id_prime_list = [[]] * math.ceil(len(n_id_list) / khop)
idx_prime = 0

for idx in range(0, len(n_id_list), khop):
	n_id_prime = n_id_list[idx]
	if idx <= len(n_id_list) - khop:
		for i in range(idx + 1, idx + khop):
			n_id_prime = torch.cat((n_id_prime, n_id_list[i])).unique()
	else:
		for i in range(idx, len(n_id_list)):
			n_id_prime = torch.cat((n_id_prime, n_id_list[i])).unique()
	n_id_prime_list[idx_prime] = n_id_prime
	idx_prime += 1

print('\nopt3 torch.cat unique(): ', time.time() - tic)

# import pdb; pdb.set_trace()
'''

'''
tic = time.time()
n_id_prime_list = [[]] * math.ceil(len(n_id_list) / khop)
idx_prime = 0

for i in range(len(n_id_list)):
	n_id_list[i] = n_id_list[i].cuda()

for idx in range(0, len(n_id_list), khop):
	n_id_prime = n_id_list[idx]
	if idx <= len(n_id_list) - khop:
		for i in range(idx + 1, idx + khop):
			n_id_prime = torch.cat((n_id_prime, n_id_list[i]))
	else:
		for i in range(idx, len(n_id_list)):
			n_id_prime = torch.cat((n_id_prime, n_id_list[i]))
	n_id_prime = n_id_prime.unique()
	n_id_prime_list[idx_prime] = n_id_prime
	idx_prime += 1

print('\nopt4 torch.cat cuda(): ', time.time() - tic)

# import pdb; pdb.set_trace()
'''

'''
tic = time.time()
n_id_prime_list = [[]] * math.ceil(len(n_id_list) / khop)
idx_prime = 0

for i in range(len(n_id_list)):
	n_id_list[i] = n_id_list[i].cuda()

for idx in range(0, len(n_id_list), khop):
	n_id_prime = n_id_list[idx]
	if idx <= len(n_id_list) - khop:
		for i in range(idx + 1, idx + khop):
			n_id_prime = torch.cat((n_id_prime, n_id_list[i])).unique()
	else:
		for i in range(idx, len(n_id_list)):
			n_id_prime = torch.cat((n_id_prime, n_id_list[i])).unique()
	n_id_prime_list[idx_prime] = n_id_prime
	idx_prime += 1

print('\nopt5 torch.cat cuda() unique(): ', time.time() - tic)

# import pdb; pdb.set_trace()
'''
