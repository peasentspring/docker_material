#!/bin/bash
date=`date +%F_%k:%M:`
hostname=`hostname`

# -i0 -i1 for test 0 and 1 (write and read)
# -r 4 for 4 KB records
# -s 100M  for 100M files for each thread, so 1000M ~ 1G total
# -t 10 for 10 threads 
# -R for excel
# -b for filename


i=1;

#run infinitely, incrementing i on each interaction

while [ $i -ge 1 ]
do  
  sudo ./iozone -i0 -i1 -r 4 -s 100M -t 10 -Rb iozone_${date}_${hostname}_trial${i}.xls 
  let i=i+1
done
