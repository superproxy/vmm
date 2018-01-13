@echo off
if "%1"=="centos7" goto centos7 
if "%1"=="centos7_vagrant" goto centos7_vagrant
if "%1"=="ubuntu" goto  ubuntu 





:help
echo support vm
echo centos7
echo ubuntu

goto end

:centos7
echo http://cloud.centos.org/centos/7/vagrant/x86_64/images/CentOS-7-x86_64-Vagrant-1706_02.VirtualBox.box 
wget http://cloud.centos.org/centos/7/vagrant/x86_64/images/CentOS-7-x86_64-Vagrant-1706_02.VirtualBox.box  -o %ROMS%\CentOS-7-x86_64-Vagrant-1706_02.VirtualBox.box
md %ROMS%\centos7
tar -xvf  %ROMS%\CentOS-7-x86_64-Vagrant-1706_02.VirtualBox.box -C %ROMS%\centos7   
goto end
:centos7_vagrant
echo http://cloud.centos.org/centos/7/vagrant/x86_64/images/CentOS-7-x86_64-Vagrant-1706_02.VirtualBox.box 
wget http://cloud.centos.org/centos/7/vagrant/x86_64/images/CentOS-7-x86_64-Vagrant-1706_02.VirtualBox.box  -o %ROMS%\CentOS-7-x86_64-Vagrant-1706_02.VirtualBox.box
md %ROMS%\centos7
tar -xvf  %ROMS%\CentOS-7-x86_64-Vagrant-1706_02.VirtualBox.box -C %ROMS%\centos7   
goto end

:ubuntu
goto end



:end


