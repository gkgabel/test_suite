fio --name=test --filename=test1.fio --size=100m --runtime=60s --ioengine=sync --rw=randrw --direct=0 --numjobs=1000 --blocksize=4096 --group_reporting=1

#fio --name=test --filename=test2.fio --size=100m --runtime=60s --ioengine=sync --rw=randrw --direct=0 --numjobs=1000 --blocksize=4096 --group_reporting=1  &

#sleep 30

#fio --name=test2 --filename=test2.fio --size=1000m --runtime=360s --ioengine=sync --rw=randrw --direct=0 --numjobs=1000 --blocksize=4096 --group_reporting=1


