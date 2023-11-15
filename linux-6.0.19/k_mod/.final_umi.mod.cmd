cmd_/home/nikhil/k_mod/final_umi.mod := printf '%s\n'   final_umi.o | awk '!x[$$0]++ { print("/home/nikhil/k_mod/"$$0) }' > /home/nikhil/k_mod/final_umi.mod
