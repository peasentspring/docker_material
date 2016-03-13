#!/bin/sh
for((i=5;i<10;i++))
do
#ssh osv-0${i} "echo 123456 | sudo -S apt-get update ; echo 123456 | sudo -S apt-get install wget ; echo 123456 | wget -qO- https://get.docker.com/ | sh"
ssh -t osv-0${i} "wget -qO- https://get.docker.com/ | sh"
done
