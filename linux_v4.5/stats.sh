echo "---------------------------" >k_mod_output.txt
echo "---------------------------">pagetypeinfo_output.txt
echo "---------------------------" >free_mem.txt
echo "---------------------------" >pb_output.txt
rm anon_huge_page.txt
touch anon_huge_page.txt
echo "-------------------">pb_occupancy.txt
while true; do
	#rmmod Downloads/k_mod/final_umi.ko 
	#insmod Downloads/k_mod/final_umi.ko 
	dmesg | grep "Pages: Mov Unmov" | tail -1 >> k_mod_output.txt
	dmesg | grep "Pbs" | tail -1 >> k_mod_output.txt 
	dmesg | grep "Unmov_Pageblocks_using_has_unmovable_pages" | tail -1 >> pb_output.txt
	 
	cat /proc/pagetypeinfo | grep "Number of blocks" -A 3 >> pagetypeinfo_output.txt
	free >> free_mem.txt
	# Run the command and store the output in a variable
	output=$(awk '/AnonHugePages/ { if($2>4){print FILENAME " " $0; system("ps -fp " gensub(/.*\/([0-9]+).*/, "\\1", "g", FILENAME))}}' /proc/*/smaps | grep gups -B 2 | grep Anon | awk '{print $3'})

	# Check if the output is empty
	if [ -z "$output" ]; then
  # If no output, append "0" to the file
  	echo "0" >> anon_huge_page.txt
	else
  # If there is output, append it to the file
  	echo "$output"| head -1 >> anon_huge_page.txt
	fi

	dmesg | grep "Occupancy" | tail -1 >> pb_occupancy.txt
	sleep 5
done
