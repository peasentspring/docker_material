#!/usr/bin
import random
import os
import sys



if __name__ == "__main__":
    n = int(sys.argv[1])
    filename = "OS_ORDER_" + str(n) + "byte.txt"
    fh = file(filename, 'w')
    block_size = 1
    flushtime = 1
    id = 0
    while 1:
        #year = random.randint(1999, 2014)
        #month = random.randint(1, 12)
        #day = random.randint(1,30)
        #recoder = "%d|%d|%d-%02d-%02d"%(id, id, year, month, day)
        recoder = "1"
        fh.write(recoder)
        fh.write(os.linesep)
        #id += 1
        #flushtime += 1
        #if flushtime % 100 == 0:
        #    fh.flush()
        fh.flush()
        statinfo = os.stat(filename)
        if statinfo.st_size >= block_size * n:
            break
    fh.close()
