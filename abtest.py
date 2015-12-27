#!/bin/python
#coding:utf-8
import sys
import subprocess
import re

class abtest(object):
    
    def __init__(self, ab_n, host_path, test_nums):
        self.ab_n = ab_n
        self.host_path = host_path
        
    #    self.test_nums = test_nums
    
    
    #===========================================================================
    # exec the ab test, return the result
    #===========================================================================
    def abtest(self):
        p = subprocess.Popen("ab -n %d %s"%(self.ab_n, self.host_path), stdout=subprocess.PIPE, shell=True)
        self.result = p.communicate()
    
        
    #===========================================================================
    # return your want result in list, you can add additional func to the abtest
    # class
    #===========================================================================
    def get_want_result(self):
        want_result = []
        
        method_list = [method for method in dir(self) if re.match("get", method)]
        #print method_list
        method_list.remove("get_want_result")
        self.abtest()
        for each_method in method_list:
            want_result.append(eval("self.%s()" % each_method))
        
        return want_result
    
    
    #def get_time_taken(self):
    #    #print self.result
    #    regxobj = re.compile("Time taken for tests:.*(\d+\.\d+)")
    #    m = regxobj.search(self.result[0])
    #    return m.group(1)


    def get_request_per_second(self):
        #print self.result
        regxobj = re.compile("Requests per second:\s*(\d+\.\d+)")
        m = regxobj.search(self.result[0])
        return m.group(1)


if __name__ == "__main__":
    print '''I provide a ab test class for using, 
your can add your get_XXX function,
then call get_want_result to get your result'''
