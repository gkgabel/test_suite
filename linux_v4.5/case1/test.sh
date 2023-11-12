bash generator.sh &
sleep 90
bash killer.sh &
sleep 150
killall -CONT fio &
