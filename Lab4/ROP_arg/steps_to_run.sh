sudo sysctl -w kernel.randomize_va_space=0;
gcc -m32 -g -fno-stack-protector -z noexecstack -o stack_rop stack_rop.c;
sudo chown root stack_rop; sudo chmod 4755 stack_rop;


#remove if badfile exists
#touch badfile
#./stack_rop ---> This will provide "/bin/sh" string address (sh_addr) and address of ebp_foo and offset (ebp address - buffer address)


#get baz() and exit() address
#gdb -q stack_rop
#run
#gdb-peda$ p baz
#$1 = {void (int)} 0x5655632c <baz>
#gdb-peda$ disassemble baz
#Dump of assembler code for function baz:
#   0x5655632c <+0>:	endbr32 
#   0x56556330 <+4>:	push   ebp
#   0x56556331 <+5>:	mov    ebp,esp
#   0x56556333 <+7>:	push   ebx     <-- After function prologue

#q


#./exploit.py
#hexdump -v -C badfile 

#./stack_rop

#hexdump -C always shows:
#[hex bytes]  |ASCII interpretation|