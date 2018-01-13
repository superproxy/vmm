@echo off
set BOX_HOME=D:\Program Files\Oracle\VirtualBox
if exist "%BOX_HOME%"  set VIRTUAL_BOX_HOME=%BOX_HOME%
set BOX_HOME=C:\Program Files\Oracle\VirtualBox
if exist "%BOX_HOME%"  set VIRTUAL_BOX_HOME=%BOX_HOME%

set path=%VIRTUAL_BOX_HOME%;%path%


set VMM_HOME=%cd%
set ROMS=%VMM_HOME%\.box
if not exist "%ROMS%"  md  "%ROMS%"

set VMM_BIN=%VMM_HOME%\.bin
set path=%VMM_BIN%;%path%



rem https://www.virtualbox.org/manual/ch08.htm    cmd list
@doskey vbm=VBoxManage.exe $*

rem =========================== vm mirror=========================
rem  use vmmget.bat 
rem   http://cloud.centos.org/centos/7/vagrant/x86_64/images/
rem @doskey vmmcentos7=wget http://cloud.centos.org/centos/7/vagrant/x86_64/images/CentOS-7-x86_64-Vagrant-1706_02.VirtualBox.box  -o %ROMS%\centos7.box
rem =========================== vm mirror end=====================


rem ====================vm add update delete clone==============
rem import $1  filepath .vof
@doskey vmminit=VBoxManage.exe import %ROMS%\$1\box.ovf
@doskey vmmi=VBoxManage.exe import %ROMS%\$1.ova
@doskey vmmimport=VBoxManage.exe import $1 $*
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
@doskey vmmstart=VBoxManage.exe startvm  $*
@doskey vmmup=VBoxManage.exe startvm  $*
@doskey vmmstop=VBoxManage.exe controlvm $1 poweroff $*
@doskey vmmdown=VBoxManage.exe controlvm $1 poweroff $*
@doskey vmmpause=VBoxManage.exe controlvm $1 pause  $*
@doskey vmmresume=VBoxManage.exe controlvm $1 resume$*
@doskey vmmsave=VBoxManage.exe controlvm $1 savestate  $*
rem ============control vm end=====================
rem ==================info vm ==================
@doskey vmmlist=VBoxManage.exe list vms$*
@doskey vmmps=VBoxManage.exe list runningvms $*
@doskey vmminfo=VBoxManage.exe showvminfo $*

rem memory 单位MB
@doskey vmmmem=VBoxManage.exe modifyvm $1 --memory $2 
@doskey vmmcpus=VBoxManage.exe modifyvm $1 --cpus $2 
@doskey vmmrename=VBoxManage.exe modifyvm $1 --name $2 
rem ==================info vm end==================




@doskey vmmver=echo VMM v1.0

if "%1"=="ver"  echo VMM V1.0
if "%1"=="?" goto help
if "%1"=="help" goto help
rem @echo type vmm help for more information

goto end

:help
@echo *****VMM v1.0 a girl named v to help you^_^****** 
@echo ============support cmds================="
@echo vmmget   download vmfiles"
@echo vmmimport import a file into virtualbox"
@echo vmminit import a exist vm file in roms"
@echo vmmup run a vm
@echo vmmdown poweroff a vm
@echo vmmclone  clone a vm
@echo vmmremove  remove a vm
@echo vmminfo  centos7  # information about centos7
@echo vmmcpus centos7 2   #2 cores 
@echo vmmmem centos7 1000
@echo vmmrename centos7 mycentos


:end
