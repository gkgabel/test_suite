cmd_/home/nikhil/k_mod/Module.symvers := sed 's/ko$$/o/' /home/nikhil/k_mod/modules.order | scripts/mod/modpost -m -a  -o /home/nikhil/k_mod/Module.symvers -e -i Module.symvers   -T -
