@echo off

rem https://support.microsoft.com/zh-cn/help/79245
rem http://www.fpschultze.de/modules/smartfaq/faq.php?faqid=22 doskey problem


if "%vmm_init%"=="" (
 goto doinit
) else (
   goto  start
)

:doinit
echo "init vmm..."
set vmm_init=true
rem ======virutalbox env====================

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
rem
goto end



rem ==================supported   cmd==============================

:start
if "%1"=="ver"  echo VMM V1.0
if "%1"=="?" goto help
if "%1"=="help" goto help

if   "%1"=="" (
  goto help 
) else (
 goto  %1
)
goto end


rem =========================== vm virtualbox=========================
:getvm
wget http://download.virtualbox.org/virtualbox/5.2.4/VirtualBox-5.2.4-119785-Win.exe -O %VMM_BIN%\VirtualBox-5.2.4-119785-Win.exe $T %VMM_BIN%\VirtualBox-5.2.4-119785-Win.exe
goto end

:getvmext
wget http://download.virtualbox.org/virtualbox/5.2.2/Oracle_VM_VirtualBox_Extension_Pack-5.2.2-119230.vbox-extpack  -O %VMM_BIN%\Oracle_VM_VirtualBox_Extension_Pack-5.2.2-119230.vbox-extpack $T %VMM_BIN%\Oracle_VM_VirtualBox_Extension_Pack-5.2.2-119230.vbox-extpack
goto end

:ui
%VIRTUAL_BOX_HOME%\VirtualBox.exe" %2 %3 %4 
goto end

rem ====================vm add update delete clone==============
rem ova
:add
copy %2 %ROMS%
goto end

:roms
ls -1 %ROMS%
goto end

:init
VBoxManage.exe import %ROMS%\%2.ova
goto end
rem import $1  filepath .vof
:iovf
VBoxManage.exe import %ROMS%\%2\box.ovf
goto end
:import
VBoxManage.exe import %ROMS%\%2 
goto end

rem clone $1 name  $2 newname
:clone
VBoxManage.exe clonevm %2 --name %3 --register 
goto end

:clone2
VBoxManage.exe clonevm %2 --name %3  --basefolder %4 --register 
goto end 

rem  export $1 path
:export
VBoxManage.exe export %2 -o %2 
goto end

:create
VBoxManage.exe createvm --name %2 --ostype linux --register --basefolder %3 
goto end

:createtest
VBoxManage.exe createvm --name test  --ostype linux --register
goto end
:reg
VBoxManage.exe registervm %2 
goto end

:remove
VBoxManage.exe unregistervm %2 --delete 
goto end
rem ====================vm add update delete clone  end==============

rem ============control vm=====================
:start
VBoxManage.exe startvm %2 
goto end
:up
VBoxManage.exe startvm %2 --type headless 
goto end
:startgui
VBoxManage.exe startvm  %2
goto end
:stop
VBoxManage.exe controlvm %2 poweroff 
goto end
:down
VBoxManage.exe controlvm %2 poweroff
goto end
:pause
VBoxManage.exe controlvm %2 pause 
goto end
:resume
VBoxManage.exe controlvm %2 resume
goto end
:reset
VBoxManage.exe controlvm %2 reset 
goto end
:sleep
VBoxManage.exe controlvm %2 savestate
goto end
===========control vm end=====================

rem ==================info vm ==================
:list
VBoxManage.exe list vms %2
goto end
:ps
VBoxManage.exe list runningvms %2
goto end
:info
VBoxManage.exe showvminfo %2
goto end

:rename
VBoxManage.exe modifyvm %2 --name %3 
goto end

rem memory µ¥Î»MB
:mem
VBoxManage.exe modifyvm %2 --memory %3 
goto end
:cpus
VBoxManage.exe modifyvm %2 --cpus %3 
goto end
rem  none|null|nat|bridged
:network
VBoxManage.exe modifyvm %2 --nic %3 
goto end
:network_nat
VBoxManage.exe modifyvm %2 --nic1 nat 
goto end
:network_b
VBoxManage.exe modifyvm %2 --nic1  bridged
goto end
rem ip  double click icon in the left tree to show shell
rem ==================info vm end==================

rem ============ other cmds===========================
rem https://www.virtualbox.org/manual/ch08.htm    cmd list
:vbm
VBoxManage.exe %2 %3
goto end
rem ============ other cmds end=======================
:ver
echo vmm v1.0
goto end

:get
%~dp0vmmget.cmd %2
goto end

:help
@echo vmm getvm   download VirtualBox and install it"
@echo vmm getvmext   download VirtualBox's extend package and install it"
@echo vmm get tinylinux or vmmget centos7 download vmfiles into roms"
@echo vmm add add a vm file into roms"
@echo vmm init import a exist vm file in roms"
@echo vmm import import a file into virtualbox"
@echo vmm up run a vm
@echo vmm down poweroff a vm
@echo vmm clone  clone a vm
@echo vmm remove  remove a vm
@echo vmm info  centos7  # information about centos7
@echo vmm cpus centos7 2   #2 cores 
@echo vmm mem centos7 1000
@echo vmm rename centos7 mycentos
@echo *****VMM v1.0 a girl named V to assist you^_^****** 


:end
