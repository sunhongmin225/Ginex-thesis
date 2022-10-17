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


def cache_update(cache, batch_inputs, in_indices, in_positions, out_indices):
    update.cache_update(cache.cache, cache.address_table, batch_inputs, in_indices, in_positions, out_indices, cache.cache.shape[1])


def cache_update_khop(cache, batch_inputs_list, in_indices, in_positions, out_indices, idx):
    print('arcmsh::utils.py::cache_update_khop::idx =', idx)
    num_batch_inputs_list = []
    for batch_inputs_list_elem in batch_inputs_list:
        num_batch_inputs_list.append(batch_inputs_list_elem.shape[0])
    print('arcmsh::utils.py::cache_update_khop::1::idx =', idx)
    if idx >= 340:
        import pdb; pdb.set_trace()
    print('arcmsh::utils.py::cache_update_khop::2::idx =', idx)
    cumsum = []
    print('arcmsh::utils.py::cache_update_khop::3::idx =', idx)
    if idx >= 340:
        import pdb; pdb.set_trace()
    print('arcmsh::utils.py::cache_update_khop::4::idx =', idx)
    cumsum.append(0)
    print('arcmsh::utils.py::cache_update_khop::5::idx =', idx)
    if idx >= 340:
        import pdb; pdb.set_trace()
    print('arcmsh::utils.py::cache_update_khop::6::idx =', idx)
    for i in range(len(num_batch_inputs_list)-1):
        print('arcmsh::utils.py::cache_update_khop::7::idx =', idx)
        if idx >= 340:
            import pdb; pdb.set_trace()
        print('arcmsh::utils.py::cache_update_khop::8::idx =', idx)
        cumsum.append(cumsum[i] + num_batch_inputs_list[i])
        print('arcmsh::utils.py::cache_update_khop::9::idx =', idx)
    print('arcmsh::utils.py::cache_update_khop::10::idx =', idx)
    if idx >= 340:
        import pdb; pdb.set_trace()
    print('arcmsh::utils.py::cache_update_khop::11::idx =', idx)
    update.cache_update_khop(cache.cache, cache.address_table, batch_inputs_list, in_indices, in_positions, out_indices, cache.cache.shape[1], cumsum)
    print('arcmsh::utils.py::cache_update_khop::12::idx =', idx)


def fill_neighbor_cache(cache, rowptr, col, cached_idx, address_table, num_entries):
    sample.fill_neighbor_cache(cache, rowptr, col, cached_idx, address_table, num_entries)
