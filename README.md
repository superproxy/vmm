## Vagrant 太重了, 国内网络问题，镜像很慢.

vmm is NOT Vagrant, but likes it! 
vmm is a simple way to manage VirtualBox!


###需要安装virtual box，如果没有可以单独下载，或者使用vmm getvm来下载安装



### example1 freedos 
####1. vmm init   freedos   执行命令 安装镜像
####2. vmm start  freedos   执行命令启动镜像

### example2  tinylinux
#### vmm get tinylinux
#### vmm init tinylinux
#### vmm rename "Tiny Linux template"  --name tinylinux 
#### vmm start  tinylinux
#### vmm clone  tinylinux  tinylinux2


更多信息
vmm help
