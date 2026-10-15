#!/usr/bin/env python3

# Run "xxd -p -c 20 rev_sh.o",
# copy and paste the machine code to the following:
ori_sh ="""
48 31 c0 50 48 bb 6c 6f 3b 20 6c 73 20 2d 53 48
bb 65 63 68 6f 20 68 65 6c 53 66 c7 44 24 10 6c
61 49 89 e4 48 31 db 50 b3 63 48 c1 e3 08 b3 2d
53 49 89 e5 50 48 bb 2f 62 69 6e 2f 62 61 73 53
c6 44 24 08 68 49 89 e6 50 41 54 41 55 41 56 48
89 e6 4c 89 f7 48 31 d2 b0 3b 0f 05
"""

sh = ori_sh.replace("\n", "")

length  = int(len(sh)/2)
print("Length of the shellcode: {}".format(length))
s = 'shellcode= (\n' + '   "'
for i in range(length):
    s += "\\x" + sh[2*i] + sh[2*i+1]
    if i > 0 and i % 16 == 15: 
       s += '"\n' + '   "'
s += '"\n' + ").encode('latin-1')"
print(s)