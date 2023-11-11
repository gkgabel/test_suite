#fio --name=test --filename=test1.fio --size=1000m --runtime=60s --ioengine=sync --rw=randrw --direct=0 --numjobs=7500 --blocksize=4096 --group_reporting=1 --time_based=1  &
#sleep 30
#fio --name=test --filename=test2.fio --size=1000m --runtime=90s --ioengine=sync --rw=randrw --direct=0 --numjobs=4000 --blocksize=4096 --group_reporting=1 --time_based=1 --startdelay=0:10 &
#sleep 5
#fio --name=test --filename=test3.fio --size=1000m --runtime=90s --ioengine=sync --rw=randrw --direct=0 --numjobs=3000 --blocksize=4096 --group_reporting=1 --time_based=1 --startdelay=0:10 &
#fio --name=test --filename=test4.fio --size=100m --runtime=90s --ioengine=sync --rw=randrw --direct=0 --numjobs=4000 --blocksize=4096 --group_reporting=1 --time_based=1 --startdelay=60 &
#fio --name=test --filename=test5.fio --size=100m --runtime=90s --ioengine=sync --rw=randrw --direct=0 --numjobs=3500 --blocksize=4096 --group_reporting=1 --time_based=1 --startdelay=60 &
#fio --name=test --filename=test6.fio --size=100m --runtime=90s --ioengine=sync --rw=randrw --direct=0 --numjobs=3000 --blocksize=4096 --group_reporting=1 --time_based=1 &
#sleep 5
#fio --name=test --filename=test2.fio --size=1000m --runtime=90s --ioengine=sync --rw=randrw --direct=0 --numjobs=4000 --blocksize=4096 --group_reporting=1 --time_based=1 --startdelay=0:10 &
#fio --name=test2 --filename=test3.fio --size=100m --runtime=300s --ioengine=sync --rw=randrw --direct=0 --numjobs=2500 --blocksize=4096 --group_reporting=1 --time_based=1 &
#sleep 5
fio --name=test2 --filename=test4.fio --size=1000m --runtime=60s --ioengine=sync --rw=randwrite --direct=1 --numjobs=8700 --blocksize=4096 --group_reporting=1 --time_based=1  &


#ps -eo pid,cmd | grep 'fio --name=test2'


#echo ps -eo pid,cmd | grep 'fio --name=test2'
#echo "$pids" | wc -w





