echo "new test" >> gups_log.txt
for i in {1..20};do
        echo "iter $i" >> gups_log.txt
        echo "---------------------------" >> gups_log.txt
        bash gups_test.sh >>  gups_log.txt 
        echo "---------huge page volume in KB------------------" >> gups_log.txt
# here just taking 20 tail entries because I have seen empirically that time does not go beyond 100sec and we are sampling evry 5 sec
#if any of the above assumptions change chamnge the below lines
        cat  ../anon_huge_page.txt | tail -n 20 >> gups_log.txt
        echo "---------gups memory footprint in KB------------" >> gups_log.txt 
#the above comment applies here too
        cat ../gups_mem_output.txt | tail -n 20 >> gups_log.txt
        echo "----------------------------------------------" >> gups_log.txt
#A major hazard observedn was that some reading might be supressed due to ??? so not everything here is sample in the fixed time I set
done
