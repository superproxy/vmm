vmm
#echo ÍÆ¼ö¶ÀÁ¢ÏÂÔØ
vmmget  centos7 
vmminit centos7
vbm  modifyvm "centos-7-1-1.x86_64"  --name centos7
vmmstart  centos7
vmmclone  centos7  centos7_2

rem   user:root  password:vagrant
