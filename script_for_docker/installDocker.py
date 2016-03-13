import pexpect
import threading
import sys
import os

def main(item):
	cmd = '''ssh -t %s "wget -qO- https://get.docker.com/ | sh"''' % item
        print cmd
	child = pexpect.spawn('/bin/bash',['-c', cmd], timeout=2000)
        child.logfile = sys.stdout
	i = child.expect(['osv:', pexpect.EOF, pexpect.TIMEOUT])
	if i == 0:
		child.sendline("123456")
                child.expect(pexpect.EOF)
                child = pexpect.spawn('''ssh -t %s "sudo usermod -aG docker osv"''' % item)
                child.logfile = sys.stdout
                child.expect('password for osv:')
                child.sendline("123456")
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
	for i in range(5,10):
		hostname.append("osv-0%d"%i)
        print "hostname is:", hostname
	for item in hostname:
		t = threading.Thread(target=main, args=(item,))
                t.start()

	
