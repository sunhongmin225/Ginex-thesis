from lib.cpp_extension.wrapper import *


def tensor_free(t):
    free.tensor_free(t)


def gather_ginex(feature_file, idx, feature_dim, cache):
    return gather.gather_ginex(feature_file, idx, feature_dim, cache.cache, cache.address_table)


def gather_mmap(features, idx):
    return gather.gather_mmap(features, idx, features.shape[1])


def load_float32(path, size):
    return mt_load.load_float32(path, size)


def load_int64(path, size):
    return mt_load.load_int64(path, size)


def load_int32(path, size):
    return mt_load.load_int32(path, size)


def cache_update(cache, batch_inputs, in_indices, in_positions, out_indices):
    update.cache_update(cache.cache, cache.address_table, batch_inputs, in_indices, in_positions, out_indices, cache.cache.shape[1])


def cache_update_khop(cache, batch_inputs_list, in_indices, in_positions, out_indices, idx):
    num_batch_inputs_list = []
    for batch_inputs_list_elem in batch_inputs_list:
        num_batch_inputs_list.append(batch_inputs_list_elem.shape[0])
    cumsum = []
    cumsum.append(0)
    for i in range(len(num_batch_inputs_list)-1):
        cumsum.append(cumsum[i] + num_batch_inputs_list[i])
    update.cache_update_khop(cache.cache, cache.address_table, batch_inputs_list, in_indices, in_positions, out_indices, cache.cache.shape[1], cumsum, idx)


def fill_neighbor_cache(cache, rowptr, col, cached_idx, address_table, num_entries):
    sample.fill_neighbor_cache(cache, rowptr, col, cached_idx, address_table, num_entries)


def fill_neighbor_cache_int32(cache, rowptr, col, cached_idx, address_table, num_entries):
    sample.fill_neighbor_cache_int32(cache, rowptr, col, cached_idx, address_table, num_entries)
