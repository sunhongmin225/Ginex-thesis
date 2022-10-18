#include <stdlib.h>
#include <aio.h>
#include <omp.h>
#include <unistd.h>
#include <fcntl.h>
#include <torch/extension.h>
#include <Python.h>
#include <pybind11/pybind11.h>
#include <torch/script.h>
#include <errno.h>
#include <cstring>
#include <inttypes.h>
#include <ATen/ATen.h>
#include <vector>

void cache_update(torch::Tensor cache, torch::Tensor address_table, torch::Tensor batch_inputs, torch::Tensor in_indices, torch::Tensor in_positions, torch::Tensor out_indices, int64_t num_features){

        auto cache_data = cache.data_ptr<float>();
        auto address_table_data = address_table.data_ptr<int32_t>();
        auto batch_inputs_data = batch_inputs.data_ptr<float>();
        auto in_indices_data = in_indices.data_ptr<int64_t>();
        auto in_positions_data = in_positions.data_ptr<int32_t>();
        auto out_indices_data = out_indices.data_ptr<int64_t>();

        int64_t num_idx = in_indices.numel();
        int64_t feature_size = num_features*sizeof(float);

        #pragma omp parallel for num_threads(torch::get_num_threads())
        for (int64_t n = 0; n < num_idx; n++) {
                int32_t cache_out_idx = address_table_data[out_indices_data[n]];
                memcpy(cache_data+num_features*cache_out_idx, batch_inputs_data+num_features*in_positions_data[n], feature_size);
                address_table_data[in_indices_data[n]] = cache_out_idx;
                address_table_data[out_indices_data[n]] = -1;
        }

        return;
}

void cache_update_khop(torch::Tensor cache, torch::Tensor address_table, std::vector<torch::Tensor> batch_inputs_list, torch::Tensor in_indices, torch::Tensor in_positions, torch::Tensor out_indices, int64_t num_features, std::vector<int64_t> cumsum, int64_t idx){

        auto cache_data = cache.data_ptr<float>();
        auto address_table_data = address_table.data_ptr<int32_t>();
        auto batch_inputs_list_0_data = batch_inputs_list[0].data_ptr<float>();
        std::vector<decltype(batch_inputs_list_0_data)> batch_inputs_list_data_vector;
        for (int i = 0; i < batch_inputs_list.size(); i++) {
                batch_inputs_list_data_vector.push_back(batch_inputs_list[i].data_ptr<float>());
        }
        auto in_indices_data = in_indices.data_ptr<int64_t>();
        auto in_positions_data = in_positions.data_ptr<int32_t>();
        auto out_indices_data = out_indices.data_ptr<int64_t>();

        int64_t num_idx = in_indices.numel();
        int64_t feature_size = num_features*sizeof(float);

        // printf("arcmsh::update::num_idx = %d, idx = %d, batch_inputs_list_data_vector.size() = %d\n", num_idx, idx, batch_inputs_list_data_vector.size());

        #pragma omp parallel for num_threads(torch::get_num_threads())
        for (int64_t n = 0; n < num_idx; n++) {
                int32_t cache_out_idx = address_table_data[out_indices_data[n]];
                for (int64_t i = batch_inputs_list.size() - 1; i >= 0; i--) {
                        if (in_positions_data[n] - cumsum[i] >= 0) {
                                memcpy(cache_data+num_features*cache_out_idx, batch_inputs_list_data_vector[i]+num_features*(in_positions_data[n] - cumsum[i]), feature_size);
                                break;
                        }
                }
                address_table_data[in_indices_data[n]] = cache_out_idx;
                address_table_data[out_indices_data[n]] = -1;
        }

        return;
}

PYBIND11_MODULE(update, m) {
    m.def("cache_update", &cache_update, "evict & insert cache entries with the given indices");
    m.def("cache_update_khop", &cache_update_khop, "evict & insert cache entries with the given indices for khop approximation");
}


