#!/bin/bash
echo "----" > gups_time.txt
date +%s >>gups_time.txt
mpirun -np 1 ./gups_vanilla 32 40000 4096
date +%s >>gups_time.txt
