#fio --name=test --filename=test1.fio --size=1000m --runtime=600s --ioengine=sync --rw=randrw --direct=0 --numjobs=4000 --blocksize=4096 --group_reporting=1 --time_based=1  &
#sleep 30
fio --name=test --filename=test2.fio --size=1000m --runtime=300s --ioengine=sync --rw=randrw --direct=1 --numjobs=4000 --blocksize=4096 --group_reporting=1 --time_based=1 &
sleep 20
fio --name=test --filename=test3.fio --size=1000m --runtime=350s --ioengine=sync --rw=randrw --direct=1 --numjobs=4000 --blocksize=4096 --group_reporting=1 --time_based=1 &
sleep 20
fio --name=test --filename=test4.fio --size=100m --runtime=300s --ioengine=sync --rw=randrw --direct=1 --numjobs=4000 --blocksize=4096 --group_reporting=1 --time_based=1  &
sleep 20
fio --name=test --filename=test5.fio --size=100m --runtime=350s --ioengine=sync --rw=randrw --direct=1 --numjobs=3500 --blocksize=4096 --group_reporting=1 --time_based=1  &
sleep 20
fio --name=test --filename=test6.fio --size=100m --runtime=300s --ioengine=sync --rw=randrw --direct=1 --numjobs=4000 --blocksize=4096 --group_reporting=1 --time_based=1 &
sleep 20
fio --name=test --filename=test7.fio --size=1000m --runtime=300s --ioengine=sync --rw=randrw --direct=1 --numjobs=2000 --blocksize=4096 --group_reporting=1 --time_based=1  &
sleep 20
fio --name=test2 --filename=test6.fio --size=100m --runtime=850s --ioengine=sync --rw=randrw --direct=1 --numjobs=1000 --blocksize=4096 --group_reporting=1 --time_based=1 
#sleep 5
#fio --name=test2 --filename=test4.fio --size=1000m --runtime=60s --ioengine=sync --rw=randwrite --direct=1 --numjobs=10000 --blocksize=4096 --group_reporting=1 --time_based=1  &


#ps -eo pid,cmd | grep 'fio --name=test2'


#echo ps -eo pid,cmd | grep 'fio --name=test2'
#echo "$pids" | wc -w





