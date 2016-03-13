#!/bin/bash

for((i=1;i<=9;i++))
do  
    ssh osv-0$i "echo 123456 | sudo -S reboot"
done

