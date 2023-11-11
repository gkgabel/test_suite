bash generator.sh &
sleep 120
bash killer.sh &
sleep 150
killall -CONT fio &
