#echo ÍÆ¼ö¶ÀÁ¢ÏÂÔØ
vmm get  centos7 
vmm init centos7
vmm vbm  modifyvm "centos-7-1-1.x86_64"  --name centos7
vmm start  centos7
vmm clone  centos7  centos7_2

rem   user:root  password:vagrant
