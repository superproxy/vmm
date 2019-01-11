call vmm get tinylinux
call vmm init tinylinux
call vmm rename "Tiny Linux template" tinylinux 
call vmm start  tinylinux
call vmm clone  tinylinux  tinylinux2
