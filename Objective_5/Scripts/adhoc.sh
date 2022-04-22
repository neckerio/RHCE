#!/bin/bash

ansible all -m debug -a "msg='the IP addresses are {{ groups.all }}'"

echo "Discover if Remote Nodes have Python3 installed"
sleep 2
ansible all -a "which python3"

if [ $? != 0 ]
then 
	echo "Python wasn't installed. Downloading now."
	ansible all -m raw -a "dnf install -y python3"
	echo "Testing Python3 installation"
	ansible all -a "which python3"
	echo "SUCCESS!"
else
	echo "Congratulations, Python3 is installed on your Remote Nodes"
fi

