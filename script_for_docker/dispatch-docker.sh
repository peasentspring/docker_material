#!/bin/bash


for((i=1;i<=9;i++))
do
    echo "123456" | scp -r /etc/default/docker osv-0$i:/home/osv/docker
    ssh osv-0$i "echo 123456 | sudo -S cp docker /etc/default/docker; sudo service docker restart"
done

