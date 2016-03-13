import pexpect
import threading
import sys
import os

def main(item):
	cmd = '''ssh -t %s "sudo adduser guest008"''' % item
        print cmd
	child = pexpect.spawn('/bin/bash',['-c', cmd], timeout=2000)
        child.logfile = sys.stdout
	i = child.expect(['osv:', pexpect.EOF, pexpect.TIMEOUT])
	if i == 0:
		child.sendline("123456")
                child.expect(pexpect.EOF)
                child.logfile = sys.stdout
                child.expect('Enter UNIX password:')
                child.sendline("guest008")
                child.expect('Retype new UNIX password:')
                child.sendline("guest008")
                child.expect('Full Name []:')
                child.sendline("008")
                child.expect('Room Number []')
                child.sendline("008")
                child.expect('Work Phone []:')
                child.sendline("008")
                child.expect('Home Phone []:')
                child.sendline("008")
                child.expect('Other []:')
                child.sendline("008")
                child.expect('correct? [Y/n]')
                child.sendline("y")
                child.expect(pexpect.EOF)
#                output = child.readline()
#                while output:
#                    print output
#                    output = child.readline()
        elif i == 1:
	        print "EOF"
        elif i == 2:
                print "TIMEOUT"


if __name__ == "__main__":
	hostname = []
	for i in range(4,9):
		hostname.append("osv-0%d"%i)
        print "hostname is:", hostname
	for item in hostname:
		t = threading.Thread(target=main, args=(item,))
                t.start()

	
