#!/bin/python
#coding:utf-8
import sys
import subprocess
import time
import abtest

def shutdown_stress():
        #shutdown the sress process
    cmd = '''ssh -p 8060 %s "ps aux |grep stress|grep -v grep|cut -c 9-15|xargs kill -9"''' % host_ip
    p = subprocess.Popen(cmd, shell=True)
    time.sleep(2) 

if __name__ == "__main__":
    stdout = sys.stdout
    sys.stdout = open("statics.log", "a+")
    ab_n = 10000
    host_ip = "192.168.0.20"
    host_path = ":8090"
    file_size = [2**i for i in range(0,11,2)]
    result_normal = []
    result_stress = []
    
    print "%-10s" % "file size: ",
    for item in file_size:
        print "%10d," % item
    print

    shutdown_stress()
    
    #================normal start============================================
    cmd = '''ssh -p 8060 %s "ps aux |grep stress|grep -v grep|cut -c 9-15|xargs kill -9"''' % host_ip
    p = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
    #print p.communicate()
    time.sleep(2)   
    for item in file_size:
        print >>stdout, "file size is: ", item
        ab = abtest.abtest(ab_n, host_ip + host_path + "/OS_ORDER_%d.txt"%item, 0)
        result_normal.append(ab.get_want_result())
    print "normal: ",    
    for item in result_normal:
        for each in item:
            print each+",",
    sys.stdout.flush()
    print
    #================normal end================================================
    
    #===================stress  start==========================================
    print >> stdout, "-----------------stress test start----------------------"
    #notify the hostA to add stress
    cmd = "ssh -p 8060 %s 'stress -m 10 --vm-bytes 128M'" % host_ip
    p = subprocess.Popen(cmd, shell=True)
    time.sleep(2)

    for item in file_size:
        print >> stdout, "file size is: ", item
        ab = abtest.abtest(ab_n, host_ip + host_path + "/OS_ORDER_%d.txt"%item, 0)
        result_stress.append(ab.get_want_result())        
    print "%-10s" % "stress: ",
    for item in result_stress:
        for each in item:
            print each+",",
    sys.stdout.flush()
    #================stress end================================================
     

    #print "result_normal: ", result_normal
    #print "result_stress: ", result_stress
    #for item in result_normal:
    #    for each in item:
    #        print each+",",
    #print
    sys.stdout.close()