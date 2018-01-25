@echo off
if "%1"=="tinylinux" goto tinylinux
if "%1"=="centos7" goto centos7 
if "%1"=="centos7_vagrant" goto centos7_vagrant
if "%1"=="ubuntu" goto  ubuntu 





:help
echo support vm
echo tinylinux
echo centos7
echo ubuntu

goto end


:tinylinux
echo https://communities.vmware.com/servlet/JiveServlet/downloadBody/21621-102-3-28798/Tiny%20Linux%20VM.ova
wget --no-check-certificate  -O %ROMS%\tinylinux.ova https://communities.vmware.com/servlet/JiveServlet/downloadBody/21621-102-3-28798/Tiny%20Linux%20VM.ova 
goto end


:centos7
echo http://cloud.centos.org/centos/7/vagrant/x86_64/images/CentOS-7-x86_64-Vagrant-1801_01.VirtualBox.box
if not exist "%ROMS%\CentOS-7.box" (
wget http://cloud.centos.org/centos/7/vagrant/x86_64/images/CentOS-7-x86_64-Vagrant-1801_01.VirtualBox.box  -O %ROMS%\CentOS-7.box
)
if not exist %ROMS%\centos7 (
	 md %ROMS%\centos7
)
cd %ROMS%
tar -xvf  CentOS-7.box -C centos7   
goto end


:centos7
echo http://cloud.centos.org/centos/7/vagrant/x86_64/images/CentOS-7-x86_64-Vagrant-1801_01.VirtualBox.box
set url=http://cloud.centos.org/centos/7/vagrant/x86_64/images/CentOS-7.box
if not exist "%ROMS%\CentOS-7.box" (
wget %url%  -O %ROMS%\CentOS-7.box
)
if not exist %ROMS%\centos7 (
	 md %ROMS%\centos7
)
cd %ROMS%
tar -xvf  CentOS-7.box -C centos7   

cd %VMM_HOME%
goto end




:ubuntu
goto end



:end


