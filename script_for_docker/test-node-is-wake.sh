#########################################################################
# File Name: test-node-is-wake.sh
# Author: wenjia zhao
# mail: zhaowenjia@stu.xjtu.edu.cn
# Created Time: Sat 12 Mar 2016 09:36:01 AM CST
#########################################################################
#!/bin/bash
set +x
if [ $# == 0 ]
then
	test_node=(1 2 3 4 5 6 7 8 9)
	for node in 1 2 3 4 5 6 7 8 9 
	do
	#	echo "test osv-0$node"
		ping=`ping -c 1 osv-0$node|grep loss|awk '{print $6}'|awk -F "%" '{print $1}'`
		if [ [$ping == 100] ];
		then
			echo ping osv-0$node fail
		else
			echo ping osv-0$node ok
		fi
	done
else
	for node in $@
	do
	#	echo "test osv-0$node"
		ping=`ping -c 1 osv-0$node|grep loss|awk '{print $6}'|awk -F "%" '{print $1}'`
		if [ [$ping == 100] ];
		then
			echo ping osv-0$node fail
		else
			echo ping osv-0$node ok
		fi
	done
fi

set +x
