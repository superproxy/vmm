echo ÍÆ¼ö¶ÀÁ¢ÏÂÔØ
call vmm get  centos7 
call vmm init centos7
call vmm rename "centos-7-1-1.x86_64" centos7
call vmm start  centos7
call vmm clone  centos7  centos7_2

rem   user:root  password:vagrant
