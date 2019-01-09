@echo off

rem https://support.microsoft.com/zh-cn/help/79245
rem http://www.fpschultze.de/modules/smartfaq/faq.php?faqid=22 doskey problem

rem ======virutalbox env====================
rem set TRY_BOX_HOME=C:\Program Files\Oracle\VirtualBox
rem if exist "%TRY_BOX_HOME%"  (
rem  set VIRTUAL_BOX_HOME=%BOX_HOME%
rem )

for /f "tokens=3,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Oracle\VirtualBox" /v "InstallDir" ') do Set TRY_BOX_HOME=%%i
if "%TRY_BOX_HOME:~-1%" == "\"  set  TRY_BOX_HOME=%TRY_BOX_HOME:~0,-1%
echo  box_home %TRY_BOX_HOME%
set VIRTUAL_BOX_HOME=%TRY_BOX_HOME%
echo vm_home %VIRTUAL_BOX_HOME%

set path=%VIRTUAL_BOX_HOME%;%path%
rem ======virutalbox env end====================


rem ========vmm env===============
set VMM_HOME=%~dp0
if "%VMM_HOME:~-1%" == "\"  set  VMM_HOME=%VMM_HOME:~0,-1%
set ROMS=%VMM_HOME%\.box
if not exist "%ROMS%"  md  "%ROMS%"

set VMM_BIN=%VMM_HOME%\.bin
set path=%VMM_HOME%;%VMM_BIN%;%path%
rem ========vmm env end===============


rem =========================== vm virtualbox=========================
@doskey vmmgetvm=wget http://download.virtualbox.org/virtualbox/5.2.4/VirtualBox-5.2.4-119785-Win.exe -O %VMM_BIN%\VirtualBox-5.2.4-119785-Win.exe $T %VMM_BIN%\VirtualBox-5.2.4-119785-Win.exe
@doskey vmmgetvmext=wget http://download.virtualbox.org/virtualbox/5.2.2/Oracle_VM_VirtualBox_Extension_Pack-5.2.2-119230.vbox-extpack  -O %VMM_BIN%\Oracle_VM_VirtualBox_Extension_Pack-5.2.2-119230.vbox-extpack $T %VMM_BIN%\Oracle_VM_VirtualBox_Extension_Pack-5.2.2-119230.vbox-extpack
@doskey vmmui="%VIRTUAL_BOX_HOME%\VirtualBox.exe" $*
rem =========================== vm mirror end=====================

rem =========================== vm mirror=========================
rem  use vmmget.bat 
rem   http://cloud.centos.org/centos/7/vagrant/x86_64/images/
rem @doskey vmmcentos7=wget http://cloud.centos.org/centos/7/vagrant/x86_64/images/CentOS-7-x86_64-Vagrant-1706_02.VirtualBox.box  -O %ROMS%\centos7.box
rem =========================== vm mirror end=====================



rem ====================vm add update delete clone==============
rem ova
@doskey vmmadd=copy $1 %ROMS%
@doskey vmmroms=ls -1 %ROMS%
@doskey vmminit=VBoxManage.exe import %ROMS%\$1.ova
rem import $1  filepath .vof
@doskey vmmiovf=VBoxManage.exe import %ROMS%\$1\box.ovf
@doskey vmmimport=VBoxManage.exe import %ROMS%\$1 
rem @doskey vmmpull=wget $1 -o $2 & VBoxManage.exe import $2 $*

rem clone $1 name  $2 newname
@doskey vmmclone=VBoxManage.exe clonevm $1 --name $2 --register 
@doskey vmmclone2=VBoxManage.exe clonevm $1 --name $2  --basefolder $3 --register $*

rem  export $1 path
@doskey vmmexport=VBoxManage.exe export $1 -o $1 $*

@doskey vmmcreate=VBoxManage.exe createvm --name $1 --ostype linux --register --basefolder $2 $*
@doskey vmmcreatetest=VBoxManage.exe createvm --name test  --ostype linux --register
@doskey vmmreg=VBoxManage.exe registervm $*
@doskey vmmremove=VBoxManage.exe unregistervm $1 --delete 
rem ====================vm add update delete clone  end==============

rem ============control vm=====================
@doskey vmmstart=VBoxManage.exe startvm $1 $*
@doskey vmmup=VBoxManage.exe startvm $1 --type headless 
@doskey vmmstartgui=VBoxManage.exe startvm  $*
@doskey vmmstop=VBoxManage.exe controlvm $1 poweroff $*
@doskey vmmdown=VBoxManage.exe controlvm $1 poweroff $*
@doskey vmmpause=VBoxManage.exe controlvm $1 pause  $*
@doskey vmmresume=VBoxManage.exe controlvm $1 resume $*
@doskey vmmreset=VBoxManage.exe controlvm $1 reset 
@doskey vmmsleep=VBoxManage.exe controlvm $1 savestate  $*
rem ============control vm end=====================

rem ==================info vm ==================
@doskey vmmlist=VBoxManage.exe list vms$*
@doskey vmmps=VBoxManage.exe list runningvms $*
@doskey vmminfo=VBoxManage.exe showvminfo $*
@doskey vmmrename=VBoxManage.exe modifyvm $1 --name $2 

rem memory µ¥Î»MB
@doskey vmmmem=VBoxManage.exe modifyvm $1 --memory $2 
@doskey vmmcpus=VBoxManage.exe modifyvm $1 --cpus $2 
rem  none|null|nat|bridged
@doskey vmmnetwork=VBoxManage.exe modifyvm $1 --nic $2 
@doskey vmmnetwork_nat=VBoxManage.exe modifyvm $1 --nic1 nat 
@doskey vmmnetwork_b=VBoxManage.exe modifyvm $1 --nic1  bridged
rem ip  double click icon in the left tree to show shell
rem ==================info vm end==================

rem ============ other cmds===========================
rem https://www.virtualbox.org/manual/ch08.htm    cmd list
@doskey vbm=VBoxManage.exe $*
rem ============ other cmds end=======================

@doskey vmmver=echo VMM v1.0

if "%1"=="ver"  echo VMM V1.0
if "%1"=="?" goto help
if "%1"=="help" goto help
rem @echo type vmm help for more information

goto end

:help
@echo *****VMM v1.0 a girl named V to assist you^_^****** 
@echo *supported cmds:*
@echo vmmgetvm   download VirtualBox and install it"
@echo vmmgetvmext   download VirtualBox's extend package and install it"
@echo vmmget tinylinux or vmmget centos7 download vmfiles into roms"
@echo vmmadd add a vm file into roms"
@echo vmminit import a exist vm file in roms"
@echo vmmimport import a file into virtualbox"
@echo vmmup run a vm
@echo vmmdown poweroff a vm
@echo vmmclone  clone a vm
@echo vmmremove  remove a vm
@echo vmminfo  centos7  # information about centos7
@echo vmmcpus centos7 2   #2 cores 
@echo vmmmem centos7 1000
@echo vmmrename centos7 mycentos


:end

rem exit /b


rem goto :eof


cmd /k
