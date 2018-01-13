vmm
vmmget tinylinux
vmminit tinylinux
vbm  modifyvm "Tiny Linux template"  --name tinylinux 
vmmup  tinylinux
vmmclone  tinylinux  tinylinux2
