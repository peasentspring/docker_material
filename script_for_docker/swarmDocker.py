import pexpect
import threading
import sys
import os

def main(item):
        cmd = '''ssh -t osv-0%d "docker run -d swarm join --addr=192.168.0.2%d:2375 token://045ead66c6c98151ef4010a8bdc22f5f"''' % (item,item)
        print cmd
	child = pexpect.spawn('/bin/bash',['-c', cmd], timeout=2000)
        child.logfile = sys.stdout
	i = child.expect(['osv:', pexpect.EOF, pexpect.TIMEOUT])
	if i == 0:
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
        start = 1
        end = 10
	for i in range(start, end):
		hostname.append("osv-0%d"%i)
        print "hostname is:", hostname
	for i in range(start, end):
		t = threading.Thread(target=main, args=(i,))
                t.start()

	
