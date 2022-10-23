cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sizes 25,10 --sb-size 4000 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/k_1/papers_sizes_25_10_4000_1000.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sizes 25,10 --sb-size 8000 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/k_1/papers_sizes_25_10_8000_1000.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sizes 25,10 --sb-size 16000 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/k_1/papers_sizes_25_10_16000_1000.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sizes 25,10 --sb-size 32000 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/k_1/papers_sizes_25_10_32000_1000.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sizes 25,10 --sb-size 16000 --batch-size 250 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/k_1/papers_sizes_25_10_16000_250.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sizes 25,10 --sb-size 16000 --batch-size 500 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/k_1/papers_sizes_25_10_16000_500.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sizes 25,10 --sb-size 16000 --batch-size 2000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/k_1/papers_sizes_25_10_16000_2000.out
rm -rf trace/*

cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 25,10 --sb-size 2200 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/k_1/products_sizes_25_10_2200_1000.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 25,10 --sb-size 4400 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/k_1/products_sizes_25_10_4400_1000.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 25,10 --sb-size 8800 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/k_1/products_sizes_25_10_8800_1000.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 25,10 --sb-size 17600 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/k_1/products_sizes_25_10_17600_1000.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 25,10 --sb-size 8800 --batch-size 250 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/k_1/products_sizes_25_10_8800_250.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 25,10 --sb-size 8800 --batch-size 500 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/k_1/products_sizes_25_10_8800_500.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 25,10 --sb-size 8800 --batch-size 2000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/k_1/products_sizes_25_10_8800_2000.out
rm -rf trace/*

cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sizes 25,10 --sb-size 3275 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/k_1/friendster_sizes_25_10_3275_1000.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sizes 25,10 --sb-size 6550 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/k_1/friendster_sizes_25_10_6550_1000.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sizes 25,10 --sb-size 13100 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/k_1/friendster_sizes_25_10_13100_1000.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sizes 25,10 --sb-size 26200 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/k_1/friendster_sizes_25_10_26200_1000.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sizes 25,10 --sb-size 13100 --batch-size 250 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/k_1/friendster_sizes_25_10_13100_250.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sizes 25,10 --sb-size 13100 --batch-size 500 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/k_1/friendster_sizes_25_10_13100_500.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sizes 25,10 --sb-size 13100 --batch-size 2000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/k_1/friendster_sizes_25_10_13100_2000.out
rm -rf trace/*

cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended --sizes 25,10 --sb-size 3100 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/k_1/twitter_sizes_25_10_3100_1000.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended --sizes 25,10 --sb-size 6200 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/k_1/twitter_sizes_25_10_6200_1000.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended --sizes 25,10 --sb-size 12400 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/k_1/twitter_sizes_25_10_12400_1000.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended --sizes 25,10 --sb-size 24800 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/k_1/twitter_sizes_25_10_24800_1000.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended --sizes 25,10 --sb-size 12400 --batch-size 250 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/k_1/twitter_sizes_25_10_12400_250.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended --sizes 25,10 --sb-size 12400 --batch-size 500 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/k_1/twitter_sizes_25_10_12400_500.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended --sizes 25,10 --sb-size 12400 --batch-size 2000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 1 > results/k_1/twitter_sizes_25_10_12400_2000.out
rm -rf trace/*


cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sizes 25,10 --sb-size 4000 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 2 > results/k_2/papers_sizes_25_10_4000_1000.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sizes 25,10 --sb-size 8000 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 2 > results/k_2/papers_sizes_25_10_8000_1000.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sizes 25,10 --sb-size 16000 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 2 > results/k_2/papers_sizes_25_10_16000_1000.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sizes 25,10 --sb-size 32000 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 2 > results/k_2/papers_sizes_25_10_32000_1000.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sizes 25,10 --sb-size 16000 --batch-size 250 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 2 > results/k_2/papers_sizes_25_10_16000_250.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sizes 25,10 --sb-size 16000 --batch-size 500 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 2 > results/k_2/papers_sizes_25_10_16000_500.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sizes 25,10 --sb-size 16000 --batch-size 2000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 2 > results/k_2/papers_sizes_25_10_16000_2000.out
rm -rf trace/*

cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 25,10 --sb-size 2200 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 2 > results/k_2/products_sizes_25_10_2200_1000.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 25,10 --sb-size 4400 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 2 > results/k_2/products_sizes_25_10_4400_1000.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 25,10 --sb-size 8800 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 2 > results/k_2/products_sizes_25_10_8800_1000.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 25,10 --sb-size 17600 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 2 > results/k_2/products_sizes_25_10_17600_1000.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 25,10 --sb-size 8800 --batch-size 250 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 2 > results/k_2/products_sizes_25_10_8800_250.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 25,10 --sb-size 8800 --batch-size 500 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 2 > results/k_2/products_sizes_25_10_8800_500.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 25,10 --sb-size 8800 --batch-size 2000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 2 > results/k_2/products_sizes_25_10_8800_2000.out
rm -rf trace/*

cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sizes 25,10 --sb-size 3275 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 2 > results/k_2/friendster_sizes_25_10_3275_1000.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sizes 25,10 --sb-size 6550 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 2 > results/k_2/friendster_sizes_25_10_6550_1000.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sizes 25,10 --sb-size 13100 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 2 > results/k_2/friendster_sizes_25_10_13100_1000.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sizes 25,10 --sb-size 26200 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 2 > results/k_2/friendster_sizes_25_10_26200_1000.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sizes 25,10 --sb-size 13100 --batch-size 250 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 2 > results/k_2/friendster_sizes_25_10_13100_250.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sizes 25,10 --sb-size 13100 --batch-size 500 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 2 > results/k_2/friendster_sizes_25_10_13100_500.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sizes 25,10 --sb-size 13100 --batch-size 2000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 2 > results/k_2/friendster_sizes_25_10_13100_2000.out
rm -rf trace/*

cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended --sizes 25,10 --sb-size 3100 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 2 > results/k_2/twitter_sizes_25_10_3100_1000.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended --sizes 25,10 --sb-size 6200 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 2 > results/k_2/twitter_sizes_25_10_6200_1000.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended --sizes 25,10 --sb-size 12400 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 2 > results/k_2/twitter_sizes_25_10_12400_1000.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended --sizes 25,10 --sb-size 24800 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 2 > results/k_2/twitter_sizes_25_10_24800_1000.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended --sizes 25,10 --sb-size 12400 --batch-size 250 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 2 > results/k_2/twitter_sizes_25_10_12400_250.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended --sizes 25,10 --sb-size 12400 --batch-size 500 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 2 > results/k_2/twitter_sizes_25_10_12400_500.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended --sizes 25,10 --sb-size 12400 --batch-size 2000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 2 > results/k_2/twitter_sizes_25_10_12400_2000.out
rm -rf trace/*
