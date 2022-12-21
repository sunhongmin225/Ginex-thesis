# Ginex++ Instruction Manual

1. `git clone https://github.com/sunhongmin225/Ginex-thesis.git`

2. `cd Ginex-thesis`

3. `git checkout all` (기본적으로 `all` branch가 Ginex++임.)

4. 사용 예시는 아래와 같다. (`runthesis.sh`에 실험 코드들이 들어있으므로 참고하면 된다.)

```
# cgexec -g memory:64gb python3 -W ignore run_ginex.py --dataset ogbn_products_extended --sizes 25,10 --sb-size 8800 --batch-size 1000 --neigh-cache-size 45000000000 --feature-cache-size 50000000000 --num-epochs 1 --verbose --train-only --khop 8 --zstd > results/thesis/ginex_all/products_8800_1000_k_8_fdim_256.out
```

* `--khop` 옵션에 1을 주면 khop approximation 기법을 적용하지 않은 상태가 됨.
* `--zstd` 옵션을 주지 않으면 zstd compression 기법을 적용하지 않는 상태가 됨.
