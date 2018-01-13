@echo off
set VIRTUAL_BOX_HOME=D:\Program Files\Oracle\VirtualBox
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
rem @doskey vmmcentos7=wget http://cloud.centos.org/centos/7/vagrant/x86_64/images/CentOS-7-x86_64-Vagrant-1706_02.VirtualBox.box  -o %ROMS%\centos7.box
rem =========================== vm mirror end=====================


rem ====================vm add update delete clone==============
rem import $1  filepath .vof
@doskey vmminit=VBoxManage.exe import %ROMS%\$1\box.ovf
@doskey vmmimport=VBoxManage.exe import $1 $*
rem @doskey vmmpull=wget $1 -o $2 & VBoxManage.exe import $2 $*
@doskey vmmreg=VBoxManage.exe startvm  $*

rem clone $1 name  $2 newname
@doskey vmmclone=VBoxManage.exe clonevm $1 --name $2 --register 
@doskey vmmclone2=VBoxManage.exe clonevm $1 --name $2  --basefolder $3 --register $*

rem  export $1 path
@doskey vmmexport=VBoxManage.exe export $1 -o $1 $*

@doskey vmmcreate=VBoxManage.exe createvm --name $1 --ostype linux --register --basefolder $2 $*
@doskey vmmcreatetest=VBoxManage.exe createvm --name test  --ostype linux --register
@doskey vmmadd=VBoxManage.exe registervm $*
rem ====================vm add update delete clone  end==============

rem ============control vm=====================
@doskey vmmstart=VBoxManage.exe startvm  $*
@doskey vmmup=VBoxManage.exe startvm  $*
@doskey vmmstop=VBoxManage.exe controlvm $1 poweroff $*
@doskey vmmdown=VBoxManage.exe controlvm $1 poweroff $*
@doskey vmmpause=VBoxManage.exe controlvm $1 pause  $*
@doskey vmmresume=VBoxManage.exe controlvm $1 resume$*
@doskey vmmsave=VBoxManage.exe controlvm $1 savestate  $*
@doskey vmmlist=VBoxManage.exe list vms$*
@doskey vmmps=VBoxManage.exe list runningvms $*
rem ============control vm end=====================




@doskey vmmver=echo "VMM v1.0"
@doskey vmmhelp=echo "vmminit vmmadd  vmmreg vmmup vmmver vmmhelp"

if "%1"=="?" goto help
if "%1"=="help" goto help
rem @echo type vmm help for more information

goto end

:help
@echo *****VMM v1.0 a girl named v to help you^_^****** 
@echo ============support cmds================="
@echo vmmget   download vmfiles"
@echo vmmimport import file into virtualbox"
@echo vmmup run vm
@echo vmmdown poweroff vm
@echo vmmclone  clone a vm


:end
