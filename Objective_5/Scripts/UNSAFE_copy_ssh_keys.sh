#!/bin/bash
# DANGER: This is an unsafe way to programmatically transfer ssh keys
# DANGER: This passes the password in the clear with sshpass
# DANGER: This is only done for demonstrative purposes, and only on local VMs

# WARNING: The script and output are HIDEOUS


# This does a few things:
#1. create ssh keys in your home directory with NO passphrase and a comment
#2. changes file permissions to be compatible with ssh key specficiations
#3. install sshpass to UNSAFELY copy ssh keys
#4. install nmap to scan which IPs to send ssh keys to
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



# Scan the network and save IPs with open 22 port to VAR: nmapip
nmapip=$(nmap -Pn -p 22 192.168.56.0/24 --open -oG - | awk '/Status/{ print $2 }')

# Collect local IPs to VAR: localip
localip=$(ip a | awk '/inet /{ print $2 }' | cut -d / -f 1)


# This does a few things:
#1. First echo VARs into a pipe to turn spaces into newlines with sed; then sort them
#2. Use comm to compare the two sorted streams and print items unique to VAR nmapip
#3. Into new VAR: ip (essentially a new list devoid of Local IPs)
ips=$(comm -23 <( echo $nmapip | sed 's/ /\n/g' | sort) <( echo $localip | sed 's/ /\n/g' | sort))


# copy ssh keys over each item in VAR ip using sshpass
for ip in $ips
do 
	sshpass -p "vagrant" ssh-copy-id -i ~/id_rsa.pub vagrant@$ip &&
	echo "SSH KEY ADDED TO vagrant@$ip"
done
