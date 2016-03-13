#!/bin/python
#coding:utf-8
import sys
import subprocess
import time
import abtest

def shutdown_stress(host_ip):
        #shutdown the sress process
    cmd = '''ssh peasant@%s "ps aux |grep stress|grep -v grep|cut -c 9-15|xargs kill -9"''' % stress_ip
    p = subprocess.Popen(cmd, shell=True)
    time.sleep(2) 

if __name__ == "__main__":
    stdout = sys.stdout
    sys.stdout = open("statics.log", "a+")
    ab_n = 10000
    host_ip = "192.168.0.244"
    stress_ip = "192.168.0.192"
    host_path = ":80"
#     file_size = [2**i for i in range(0,11,2)]
    file_size = ['128byte', '256byte', '512byte', '1', '4', '16', '64', '256']
    print "%-10s" % "file size: ",
    for item in file_size:
        print "%10s," % str(item),
    print
    for count_index in range(10):
        result_stress = []
    
        shutdown_stress(stress_ip)
            
        #===================stress  start==========================================
        print >> stdout, "-----------------stress test start----------------------"
        #notify the hostA to add stress
        cmd = "ssh peasant@%s 'stress -m 10 --vm-bytes 128M'" % stress_ip
        p = subprocess.Popen(cmd, shell=True)
        time.sleep(2)
    
        for item in file_size:
            print >> stdout, "file_size is: ", item
            ab = abtest.abtest(ab_n, host_ip + host_path + "/OS_ORDER_%s.txt"%str(item), 0)
            result_stress.append(ab.get_want_result("stress_%d_%s.txt" % (ab_n, str(item))))        
        print "%-10s" % "stress: ",
        for item in result_stress:
            for each in item:
                print "%10s," % each,
        sys.stdout.flush()
        print
        #================stress end================================================
    for count_index in range(10): 
        result_normal = []
        #================normal start============================================
        shutdown_stress(stress_ip)
        for item in file_size:
            print >>stdout, "file_size is: ", item
            ab = abtest.abtest(ab_n, host_ip + host_path + "/OS_ORDER_%s.txt"%str(item), 0)
            result_normal.append(ab.get_want_result("normal_%d_%s.txt" % (ab_n, str(item))))
        print "normal: ",    
        for item in result_normal:
            for each in item:
                print "%10s," % each,
        sys.stdout.flush()
        print
        #================normal end================================================
         
    sys.stdout.close()
