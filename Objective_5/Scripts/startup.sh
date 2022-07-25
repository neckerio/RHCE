#!/bin/bash

# register
subscription-manager register --username=USERNAME --password=PASSWORD

# bashrc (TERM, vi)
cat << EOF > .bashrc
TERM=xterm-256color 
export TERM 
set -o vi
EOF

echo "set -o vi" >> /home/vagrant/.bashrc
chown vagrant: /home/vagrant/.bashrc

# dnf
dnf -y install nmap vim python3

# nmap line 
nmap -Pn -p 22 192.168.50.0/24 --open -oG - | awk '/Status/{ print $2 }' | tee /home/vagrant/inventory

chown vagrant: /home/vagrant/inventory

# pip3 install ansible
pip3 install -U pip
pip3 install --upgrade ansible

# autocmd vim
echo "autocmd Filetype yaml setlocal ai sw=2 ts=2 et" >> /home/vagrant/.vimrc
echo "set number relativenumber" >> /home/vagrant/.vimrc
chown vagrant: /home/vagrant/.vimrc

# ansible.cfg
cat<< EOF > /home/vagrant/ansible.cfg
[defaults]
remote_user = vagrant
inventory = inventory
ask_pass = False
host_key_checking = False

stdout_callback = yaml
deprecation_warnings = False

[privilege_escalation]
become = True
become_method = sudo
become_user = root
become_ask_pass = False
EOF

chown vagrant: /home/vagrant/ansible.cfg
