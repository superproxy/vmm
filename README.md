## Vagrant 太重了, 国内网络问题，镜像很慢.

vmm is NOT Vagrant, but likes it! 
vmm is a simple way to manage VirtualBox!


###需要安装virtual box，如果没有可以单独下载，或者使用vmmgetvm来下载安装



## usage: start  cmd  and type following cmds


### example1 freedos 
####1. run  vmm.cmd      初始化环境
####2. vmminit   freedos   执行命令 安装镜像
####3. vmmstart  freedos   执行命令启动镜像

### example2  tinylinux
#### vmm
#### vmmget tinylinux
#### vmminit tinylinux
#### vbm  modifyvm "Tiny Linux template"  --name tinylinux 
#### vmmstart  tinylinux
#### vmmclone  tinylinux  tinylinux2


更多信息
vmm help
