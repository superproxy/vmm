vmm
vmmget tinylinux
vmminit tinylinux
vbm  modifyvm "Tiny Linux template"  --name tinylinux 
vmmstart  tinylinux
vmmclone  tinylinux  tinylinux2
