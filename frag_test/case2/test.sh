bash generator.sh
sleep 80
bash killer.sh &
sleep 150
killall -CONT fio &
