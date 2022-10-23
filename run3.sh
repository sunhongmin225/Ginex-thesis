cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sizes 25,10 --sb-size 16000 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 4 > papers_sizes_25_10_16000_1000_k_4.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 25,10 --sb-size 8800 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 4 > products_sizes_25_10_8800_1000_k_4.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sizes 25,10 --sb-size 13100 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 4 > friendster_sizes_25_10_13100_1000_k_4.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended --sizes 25,10 --sb-size 12400 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 4 > twitter_sizes_25_10_12400_1000_k_4.out

cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sizes 25,10 --sb-size 16000 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 8 > papers_sizes_25_10_16000_1000_k_8.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 25,10 --sb-size 8800 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 8 > products_sizes_25_10_8800_1000_k_8.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sizes 25,10 --sb-size 13100 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 8 > friendster_sizes_25_10_13100_1000_k_8.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended --sizes 25,10 --sb-size 12400 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 8 > twitter_sizes_25_10_12400_1000_k_8.out
rm -rf trace/*

cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sizes 25,10 --sb-size 16000 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 16 > papers_sizes_25_10_16000_1000_k_16.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 25,10 --sb-size 8800 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 16 > products_sizes_25_10_8800_1000_k_16.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sizes 25,10 --sb-size 13100 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 16 > friendster_sizes_25_10_13100_1000_k_16.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended --sizes 25,10 --sb-size 12400 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 16 > twitter_sizes_25_10_12400_1000_k_16.out

cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sizes 25,10 --sb-size 16000 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 32 > papers_sizes_25_10_16000_1000_k_32.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 25,10 --sb-size 8800 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 32 > products_sizes_25_10_8800_1000_k_32.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sizes 25,10 --sb-size 13100 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 32 > friendster_sizes_25_10_13100_1000_k_32.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended --sizes 25,10 --sb-size 12400 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 32 > twitter_sizes_25_10_12400_1000_k_32.out
rm -rf trace/*

cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sizes 25,10 --sb-size 16000 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 64 > papers_sizes_25_10_16000_1000_k_64.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 25,10 --sb-size 8800 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 64 > products_sizes_25_10_8800_1000_k_64.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sizes 25,10 --sb-size 13100 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 64 > friendster_sizes_25_10_13100_1000_k_64.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended --sizes 25,10 --sb-size 12400 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 64 > twitter_sizes_25_10_12400_1000_k_64.out

cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sizes 25,10 --sb-size 16000 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 128 > papers_sizes_25_10_16000_1000_k_128.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 25,10 --sb-size 8800 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 128 > products_sizes_25_10_8800_1000_k_128.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sizes 25,10 --sb-size 13100 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 128 > friendster_sizes_25_10_13100_1000_k_128.out
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended --sizes 25,10 --sb-size 12400 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 128 > twitter_sizes_25_10_12400_1000_k_128.out
rm -rf trace/*
