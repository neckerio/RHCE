# Inventories

> Ansible works against multiple managed nodes or “hosts” in your infrastructure at the same time, using a list or group of lists known as inventory. Once your inventory is defined, you use patterns to select the hosts or groups you want Ansible to run against. [^inventory]

---

## Objective
- Understand the core componenets of Ansible
	- Inventories


### Useful Commands

* ansible-inventory --list --yaml
* ansible-inventory --graph


### Useful Packages
* nmap

### Useful Directories/Files
* **/etc/ansible/hosts** - Default inventory location

---

### Walkthrough

1. Gather IPs of and place them in a file named "inventory"

```zsh
nmap -Pn -p 22 192.168.56.0/24 --open -oG - | awk '/Status/{ print $2 }' | tee inventory
```
- What this command means:
	- **nmap** - network exploration tool and security / port scanner
	- **-Pn** - treat all hosts as online (skip host discover). For speed
	- **-p 22** - port 22
	- **192.168.56.0/24** - scan this IP
	- **--open** - only show open ports
	- **-oG** - greppable output
	- **-** - set the ouput/filespec (not exactly sure)
	- **|** pipe into
	- **awk** - pattern scanning and processing language
	- **'/Status/{ print $2 }'** - scan for Status and print the second column
	- **|** - pipe into
	- **tee** - read from stdin and write to stdout and files
	- **inventory** - the name of the INVENTORY file

2. Edit IPs in **inventory** into Ansible Groups using the appropriate format

```zsh
[groupname1]
ip.add.re.ss

ip.add.re.ss

ip.add.re.ss


[grouname2]
ip.add.re.ss

ip.add.re.ss
```


3. Add vars
	- Although it is a deprecated practice to add vars into the **inventory** file it might be quicker during the exam.

[groupname1:vars]
ansible_python_interpreter = /usr/bin/python3
ansible_ssh_private_key_file = /path/to/ssh_private_key


4. Alternative way to add vars

```zsh
mkdir group_vars
```

```zsh
vim group_vars/groupname1
```
* when adding vars in group_vars/host_vars be sure to use ***:*** as delimeter instead of ***=***.
























---
[^inventory]: Quote from [Ansible Docs](https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html)

