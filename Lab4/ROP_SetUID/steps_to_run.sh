sudo sysctl -w kernel.randomize_va_space=0;
gcc -m32 -g -fno-stack-protector -z noexecstack -o stack_rop stack_rop.c;
sudo chown root stack_rop
sudo chmod 4755 stack_rop

#export MYSHELL="/bin/sh"
#remove if badfile exists
#touch badfile
#./stack_rop ---> This will provide "/bin/sh" string address (sh_addr) and address of ebp_foo and offset (ebp address - buffer address)

#gdb -q stack_rop
#run
#p system
#p exit
#p setuid
#p sprintf
#disassemble bar
#Get leaveret address
#q

#./exploit.py
#hexdump -v -C badfile --> viewing badfile
#./stack_rop