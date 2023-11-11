#pids=$(ps -eo pid,cmd | grep 'fio --name=test2' | grep -v 'grep' | awk '{print $1}') 

#ps -eo pid,cmd | grep 'fio --name=test2'


#echo ps -eo pid,cmd | grep 'fio --name=test2'
#echo "$pids" | wc -w

#for pid in $pids; do
#	kill -STOP $pid
#done



pids=$(ps -eo pid,cmd | grep 'fio --name=test2' | grep -v 'grep'  | awk '{print $1}')

echo "$pids" | wc -w

count=0
ps -eo pid,cmd | grep 'fio --name=test2' | grep -v 'grep'

for pid in $pids; do
	((count++))
	if [ $((count%10)) -eq 0 ]; then
       	kill -STOP $pid
       fi
done



