#!/bin/bash
echo "----" > gups_time.txt
date +%s >>gups_time.txt
taskset -c 0,6 ./gups_vanilla 32 2000000 1024
date +%s >>gups_time.txt
