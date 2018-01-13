## Vagrant 太重了, 国内网络问题，镜像很慢.

vmm is NOT Vagrant, but likes it! 
vmm is a simple way to manage VirtualBox!


## usage: start  cmd  and type following cmds


### example1 freedos 
#### vmm
#### vmminit   freedos
#### vmmstart  freedos

### example2  tinylinux
#### vmm
#### vmmget tinylinux
#### vmminit tinylinux
#### vbm  modifyvm "Tiny Linux template"  --name tinylinux 
#### vmmstart  tinylinux
#### vmmclone  tinylinux  tinylinux2
