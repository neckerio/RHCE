#!/bin/bash

ansible all -m setup -a "filter=ansible_distribution" | awk '/192/{ print $1 } /distrib/{ print $2 }' | tr -d \" | tr '\n' ' ' | awk '{ printf "This node %s uses %s\nThis node %s uses %s\n", $1, $2, $3, $4}'

HOSTNAMES=$(ansible all -m debug -a "var=inventory_hostname" | awk '/host/{ print $2 }' | tr -d \")

echo $HOSTNAMES

for host in $HOSTNAMES
do
	echo "This Host is $host"
done
