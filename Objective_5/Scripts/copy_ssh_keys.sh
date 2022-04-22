#!/bin/bash

iplist=$(nmap -Pn -p 22 192.168.56.0/24 --open -oG - | awk '/Status/{ print $2 }')
IFS=$'/n'

bash <<"EOF"
ssh-keygen -f ~/id_rsa -N "" -C "rhel1 -> rhel2/3"
echo "##################### 	KEY CREATED 	###########################"
chmod 0600 id_rsa; chmod 0644 id_rsa.pub; chmod 0755 .
echo "####################	KEYS CHMODED	###########################"
sudo dnf install -y sshpass
echo "####################	SSHPASS DOWNLOADED ###########################"
sudo dnf install -y nmap
echo "####################	NMAP DOWNLOADED ###########################"
EOF

for ip in "$iplist"
do 
	sshpass -p "vagrant" ssh-copy-id -i ~/id_rsa.pub vagrant@$ip &&
	echo "SSH KEY ADDED TO vagrant@$ip"
done


