# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sizes 25,10 --sb-size 16000 --batch-size 250 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 8 --zstd > results/thesis/ginex_all/papers_16000_250_k_8.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sizes 25,10 --sb-size 16000 --batch-size 500 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 8 --zstd > results/thesis/ginex_all/papers_16000_500_k_8.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sizes 25,10 --sb-size 16000 --batch-size 750 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 8 --zstd > results/thesis/ginex_all/papers_16000_750_k_8.out
# rm -rf trace/*

# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 25,10 --sb-size 8800 --batch-size 250 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 8 --zstd > results/thesis/ginex_all/products_8800_250_k_8.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 25,10 --sb-size 8800 --batch-size 500 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 8 --zstd > results/thesis/ginex_all/products_8800_500_k_8.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 25,10 --sb-size 8800 --batch-size 750 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 8 --zstd > results/thesis/ginex_all/products_8800_750_k_8.out
# rm -rf trace/*

# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sizes 25,10 --sb-size 15600 --batch-size 250 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 8 --zstd > results/thesis/ginex_all/friendster_15600_250_k_8.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sizes 25,10 --sb-size 15600 --batch-size 500 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 8 --zstd > results/thesis/ginex_all/friendster_15600_500_k_8.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sizes 25,10 --sb-size 15600 --batch-size 750 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 8 --zstd > results/thesis/ginex_all/friendster_15600_750_k_8.out
# rm -rf trace/*

# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended_6 --sizes 25,10 --sb-size 21600 --batch-size 250 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 8 --zstd > results/thesis/ginex_all/twitter_extended_6_21600_250_k_8.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended_6 --sizes 25,10 --sb-size 21600 --batch-size 500 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 8 --zstd > results/thesis/ginex_all/twitter_extended_6_21600_500_k_8.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended_6 --sizes 25,10 --sb-size 21600 --batch-size 740 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 8 --zstd > results/thesis/ginex_all/twitter_extended_6_21600_750_k_8.out
# rm -rf trace/*



# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sizes 25,10 --sb-size 16000 --batch-size 250 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/papers_16000_250_k_8.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sizes 25,10 --sb-size 16000 --batch-size 500 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/papers_16000_500_k_8.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sizes 25,10 --sb-size 16000 --batch-size 750 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/papers_16000_750_k_8.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sizes 25,10 --sb-size 16000 --batch-size 2000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/papers_16000_2000_k_8.out
# rm -rf trace/*

# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 25,10 --sb-size 8800 --batch-size 250 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/products_8800_250_k_8.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 25,10 --sb-size 8800 --batch-size 500 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/products_8800_500_k_8.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 25,10 --sb-size 8800 --batch-size 750 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/products_8800_750_k_8.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 25,10 --sb-size 8800 --batch-size 2000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/products_8800_2000_k_8.out
# rm -rf trace/*

# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sizes 25,10 --sb-size 15600 --batch-size 250 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/friendster_15600_250_k_8.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sizes 25,10 --sb-size 15600 --batch-size 500 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/friendster_15600_500_k_8.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sizes 25,10 --sb-size 15600 --batch-size 750 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/friendster_15600_750_k_8.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sizes 25,10 --sb-size 15600 --batch-size 2000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/friendster_15600_2000_k_8.out
# rm -rf trace/*

# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended_6 --sizes 25,10 --sb-size 21600 --batch-size 250 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/twitter_extended_6_21600_250_k_8.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended_6 --sizes 25,10 --sb-size 21600 --batch-size 500 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/twitter_extended_6_21600_500_k_8.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended_6 --sizes 25,10 --sb-size 21600 --batch-size 740 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/twitter_extended_6_21600_750_k_8.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended_6 --sizes 25,10 --sb-size 21600 --batch-size 2000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/twitter_extended_6_21600_2000_k_8.out
# rm -rf trace/*



# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sizes 25,10 --sb-size 4000 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 8 --zstd > results/thesis/ginex_all/papers_4000_1000_k_8.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sizes 25,10 --sb-size 8000 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 8 --zstd > results/thesis/ginex_all/papers_8000_1000_k_8.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sizes 25,10 --sb-size 12000 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 8 --zstd > results/thesis/ginex_all/papers_12000_1000_k_8.out
# rm -rf trace/*

# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 25,10 --sb-size 2200 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 8 --zstd > results/thesis/ginex_all/products_2200_1000_k_8.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 25,10 --sb-size 4400 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 8 --zstd > results/thesis/ginex_all/products_4400_1000_k_8.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 25,10 --sb-size 6600 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 8 --zstd > results/thesis/ginex_all/products_6600_1000_k_8.out
# rm -rf trace/*

# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sizes 25,10 --sb-size 3900 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 8 --zstd > results/thesis/ginex_all/friendster_3900_1000_k_8.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sizes 25,10 --sb-size 7800 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 8 --zstd > results/thesis/ginex_all/friendster_7800_1000_k_8.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sizes 25,10 --sb-size 11700 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 8 --zstd > results/thesis/ginex_all/friendster_11700_1000_k_8.out
# rm -rf trace/*

# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended_6 --sizes 25,10 --sb-size 5400 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 8 --zstd > results/thesis/ginex_all/twitter_extended_6_5400_1000_k_8.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended_6 --sizes 25,10 --sb-size 10800 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 8 --zstd > results/thesis/ginex_all/twitter_extended_6_10800_1000_k_8.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended_6 --sizes 25,10 --sb-size 16200 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 8 --zstd > results/thesis/ginex_all/twitter_extended_6_16200_1000_k_8.out
# rm -rf trace/*



# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sizes 50,10 --sb-size 4000 --batch-size 250 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/papers_sizes_50_10_4000_250.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sizes 50,10 --sb-size 4000 --batch-size 500 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/papers_sizes_50_10_4000_500.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sizes 50,10 --sb-size 4000 --batch-size 750 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/papers_sizes_50_10_4000_750.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sizes 50,10 --sb-size 4000 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/papers_sizes_50_10_4000_1000.out
# rm -rf trace/*

# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sizes 15,10,5 --sb-size 4000 --batch-size 250 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/papers_sizes_15_10_5_4000_250.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sizes 15,10,5 --sb-size 4000 --batch-size 500 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/papers_sizes_15_10_5_4000_500.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sizes 15,10,5 --sb-size 4000 --batch-size 750 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/papers_sizes_15_10_5_4000_750.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sizes 15,10,5 --sb-size 4000 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/papers_sizes_15_10_5_4000_1000.out
# rm -rf trace/*

# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sizes 10,10,10 --sb-size 4000 --batch-size 250 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/papers_sizes_10_10_10_4000_250.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sizes 10,10,10 --sb-size 4000 --batch-size 500 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/papers_sizes_10_10_10_4000_500.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sizes 10,10,10 --sb-size 4000 --batch-size 750 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/papers_sizes_10_10_10_4000_750.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sizes 10,10,10 --sb-size 4000 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/papers_sizes_10_10_10_4000_1000.out
# rm -rf trace/*


# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sizes 25,10 --sb-size 4000 --batch-size 250 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/papers_4000_250.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sizes 25,10 --sb-size 4000 --batch-size 500 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/papers_4000_500.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sizes 25,10 --sb-size 4000 --batch-size 750 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/papers_4000_750.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sizes 25,10 --sb-size 4000 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/papers_4000_1000.out
# rm -rf trace/*


# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 50,10 --sb-size 2200 --batch-size 250 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/products_sizes_50_10_2200_250.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 50,10 --sb-size 2200 --batch-size 500 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/products_sizes_50_10_2200_500.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 50,10 --sb-size 2200 --batch-size 750 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/products_sizes_50_10_2200_750.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 50,10 --sb-size 2200 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/products_sizes_50_10_2200_1000.out
# rm -rf trace/*

# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 15,10,5 --sb-size 2200 --batch-size 250 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/products_sizes_15_10_5_2200_250.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 15,10,5 --sb-size 2200 --batch-size 500 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/products_sizes_15_10_5_2200_500.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 15,10,5 --sb-size 2200 --batch-size 750 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/products_sizes_15_10_5_2200_750.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 15,10,5 --sb-size 2200 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/products_sizes_15_10_5_2200_1000.out
# rm -rf trace/*

# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 10,10,10 --sb-size 2200 --batch-size 250 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/products_sizes_10_10_10_2200_250.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 10,10,10 --sb-size 2200 --batch-size 500 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/products_sizes_10_10_10_2200_500.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 10,10,10 --sb-size 2200 --batch-size 750 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/products_sizes_10_10_10_2200_750.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 10,10,10 --sb-size 2200 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/products_sizes_10_10_10_2200_1000.out
# rm -rf trace/*

# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 25,10 --sb-size 2200 --batch-size 250 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/products_2200_250.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 25,10 --sb-size 2200 --batch-size 500 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/products_2200_500.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 25,10 --sb-size 2200 --batch-size 750 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/products_2200_750.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 25,10 --sb-size 2200 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/products_2200_1000.out
# rm -rf trace/*



# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sizes 50,10 --sb-size 3900 --batch-size 250 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/friendster_sizes_50_10_3900_250.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sizes 50,10 --sb-size 3900 --batch-size 500 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/friendster_sizes_50_10_3900_500.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sizes 50,10 --sb-size 3900 --batch-size 750 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/friendster_sizes_50_10_3900_750.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sizes 50,10 --sb-size 3900 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/friendster_sizes_50_10_3900_1000.out
# rm -rf trace/*

# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sizes 15,10,5 --sb-size 3900 --batch-size 250 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/friendster_sizes_15_10_5_3900_250.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sizes 15,10,5 --sb-size 3900 --batch-size 500 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/friendster_sizes_15_10_5_3900_500.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sizes 15,10,5 --sb-size 3900 --batch-size 750 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/friendster_sizes_15_10_5_3900_750.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sizes 15,10,5 --sb-size 3900 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/friendster_sizes_15_10_5_3900_1000.out
# rm -rf trace/*

# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sizes 10,10,10 --sb-size 3900 --batch-size 250 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/friendster_sizes_10_10_10_3900_250.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sizes 10,10,10 --sb-size 3900 --batch-size 500 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/friendster_sizes_10_10_10_3900_500.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sizes 10,10,10 --sb-size 3900 --batch-size 750 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/friendster_sizes_10_10_10_3900_750.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sizes 10,10,10 --sb-size 3900 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/friendster_sizes_10_10_10_3900_1000.out
# rm -rf trace/*

# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sizes 25,10 --sb-size 3900 --batch-size 250 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/friendster_3900_250.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sizes 25,10 --sb-size 3900 --batch-size 500 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/friendster_3900_500.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sizes 25,10 --sb-size 3900 --batch-size 750 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/friendster_3900_750.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sizes 25,10 --sb-size 3900 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/friendster_3900_1000.out
# rm -rf trace/*



# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended_6 --sizes 10,10,10 --sb-size 1600 --batch-size 250 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/twitter_extended_6_sizes_10_10_10_1600_250.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended_6 --sizes 10,10,10 --sb-size 1600 --batch-size 500 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/twitter_extended_6_sizes_10_10_10_1600_500.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended_6 --sizes 10,10,10 --sb-size 1600 --batch-size 750 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/twitter_extended_6_sizes_10_10_10_1600_750.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended_6 --sizes 10,10,10 --sb-size 1600 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/twitter_extended_6_sizes_10_10_10_1600_1000.out
# rm -rf trace/*

# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended_6 --sizes 25,10 --sb-size 1600 --batch-size 250 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/twitter_extended_6_1600_250.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended_6 --sizes 25,10 --sb-size 1600 --batch-size 500 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/twitter_extended_6_1600_500.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended_6 --sizes 25,10 --sb-size 1600 --batch-size 750 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/twitter_extended_6_1600_750.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended_6 --sizes 25,10 --sb-size 1600 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/twitter_extended_6_1600_1000.out
# rm -rf trace/*

# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended_6 --sizes 50,10 --sb-size 1600 --batch-size 250 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/twitter_extended_6_sizes_50_10_1600_250.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended_6 --sizes 50,10 --sb-size 1600 --batch-size 500 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/twitter_extended_6_sizes_50_10_1600_500.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended_6 --sizes 50,10 --sb-size 1600 --batch-size 750 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/twitter_extended_6_sizes_50_10_1600_750.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended_6 --sizes 50,10 --sb-size 1600 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/twitter_extended_6_sizes_50_10_1600_1000.out
# rm -rf trace/*

# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended_6 --sizes 15,10,5 --sb-size 1600 --batch-size 250 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/twitter_extended_6_sizes_15_10_5_1600_250.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended_6 --sizes 15,10,5 --sb-size 1600 --batch-size 500 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/twitter_extended_6_sizes_15_10_5_1600_500.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended_6 --sizes 15,10,5 --sb-size 1600 --batch-size 750 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/twitter_extended_6_sizes_15_10_5_1600_750.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended_6 --sizes 15,10,5 --sb-size 1600 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/twitter_extended_6_sizes_15_10_5_1600_1000.out
rm -rf trace/*


# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sizes 25,10 --sb-size 4000 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/papers_4000_1000_k_8.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sizes 25,10 --sb-size 8000 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/papers_8000_1000_k_8.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sizes 25,10 --sb-size 12000 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/papers_12000_1000_k_8.out
# rm -rf trace/*

# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 25,10 --sb-size 2200 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/products_2200_1000_k_8.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 25,10 --sb-size 4400 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/products_4400_1000_k_8.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 25,10 --sb-size 6600 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/products_6600_1000_k_8.out
# rm -rf trace/*

# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sizes 25,10 --sb-size 3900 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/friendster_3900_1000_k_8.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sizes 25,10 --sb-size 7800 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/friendster_7800_1000_k_8.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sizes 25,10 --sb-size 11700 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/friendster_11700_1000_k_8.out
# rm -rf trace/*

# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended_6 --sizes 25,10 --sb-size 5400 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/twitter_extended_6_5400_1000_k_8.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended_6 --sizes 25,10 --sb-size 10800 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/twitter_extended_6_10800_1000_k_8.out
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended_6 --sizes 25,10 --sb-size 16200 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/thesis/ginex/twitter_extended_6_16200_1000_k_8.out
# rm -rf trace/*
