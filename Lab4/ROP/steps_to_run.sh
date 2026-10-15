sudo sysctl -w kernel.randomize_va_space=0;
gcc -m32 -g -fno-stack-protector -z noexecstack -o stack_rop stack_rop.c;
sudo chown root stack_rop; sudo chmod 4755 stack_rop;

#--------------------get bar() and exit() address-------
#touch badfile
#gdb -q stack_rop
#run
# gdb-peda$ p bar
#$1 = {void ()} 0x565562ed <bar>
#gdb-peda$ p exit
#$2 = {<text variable, no debug info>} 0xf7e04f80 <exit>

#--------Get the offset = ebp - buffer -----------------
#b foo
#run
#next
#p $ebp
#p &buffer
#p/d rbp-buffer

#-----put these addresses in exploit.py-------
#./exploit.py
#hexdump -v -C badfile 

#./stack_rop

#ebp & buffer addresses from debugging and while running the program is different because during debugging extra infor is added

#-------focus only on the offset = ebp - buffer-------

#as based on offset we should decide where is RT address.

#hexdump -C always shows:
#[hex bytes]  |ASCII interpretation|
