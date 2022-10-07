cgexec -g memory:64gb python3 -W ignore run_baseline.py --dataset ogbn_papers_extended --sb-size 3300 --num-epochs 1 --train-only
cgexec -g memory:64gb python3 -W ignore run_baseline.py --dataset friendster_extended --sb-size 3600 --num-epochs 1 --train-only
cgexec -g memory:64gb python3 -W ignore run_baseline.py --dataset ogbn_products_extended --sb-size 2100 --num-epochs 1 --train-only
cgexec -g memory:64gb python3 -W ignore run_baseline.py --dataset twitter_extended --sb-size 6400 --num-epochs 1 --train-only

cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_papers_extended --sb-size 3300 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset friendster_extended --sb-size 3600 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sb-size 2100 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only
cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset twitter_extended --sb-size 6400 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only

sudo PYTHONPATH=/home/sunhong/.local/lib/python3.8/site-packages python3 -W ignore run_ginex.py --sb-size 2100 --num-epochs 1 --neigh-cache-size 15000000000 --feature-cache-size 6000000000 --verbose --train-only --khop 1
