#!/bin/bash
touch "output.csv"

echo "Readings taken at an interval of======================== 30 sec">output.csv

echo "total mem=32821404, Total Swap Mem=33238012, Total Pages=8385343, Total Pbs=16378" >> output.csv

echo "used mem+shared_mem,used swap,unmov pages,unmov pbs, 2mb huge pages,used mem+shared_mem%,used swap%,unmov pages%,unmov pbs%,2mb huge page %, 25% occupancy,50% occupancy,75% occupancy,100% occupancy">>output.csv

(grep -oE 'Pages: Mov Unmov [0-9]+ [0-9]+' k_mod_output.txt | awk '{print $5}') > tmp1

(grep -oE 'Pbs: Mov Unmov [0-9]+ [0-9]+' k_mod_output.txt | awk '{print $5}') > tmp2

(grep -oE 'Mem:\s+[0-9]+\s+[0-9]+\s+[0-9]+\s+[0-9]+\s+[0-9]+\s+[0-9]+' free_mem.txt | awk '{sum = $2-$7; print sum}') > tmp3

(grep -oE 'Swap:\s+[0-9]+\s+[0-9]+' free_mem.txt | awk '{print $3}') > tmp4

cat anon_huge_page.txt > tmp9

cat pb_occupancy.txt | grep "Unmov"| awk '{for (i = 11; i <= 14; i++) {printf "%s,", $i; } printf "\n";}' > tmp11

(grep -oE 'Pages: Mov Unmov [0-9]+ [0-9]+' pb_output.txt | awk '{print $4}' )  > tmp12

paste tmp3 | awk '{printf "%.4f\n", $1 / 32821404 * 100}' > tmp5

paste tmp4 | awk '{printf "%.4f\n", $1 / 33238012 * 100}' > tmp6

paste tmp1 | awk '{printf "%.4f\n", $1 / 8385343 *100}' > tmp7

paste tmp2 | awk '{printf "%.4f\n", $1 / 16378 * 100}' > tmp8

paste tmp9 | awk '{printf "%.4f\n", $1 / 32821404 * 100}' > tmp10

paste -d ',' tmp3 tmp4 tmp1 tmp2 tmp9 tmp5 tmp6 tmp7 tmp8 tmp10 tmp11 tmp12>> output.csv

rm tmp*
