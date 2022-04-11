# Inventories

> Ansible works against multiple managed nodes or “hosts” in your infrastructure at the same time, using a list or group of lists known as inventory. Once your inventory is defined, you use patterns to select the hosts or groups you want Ansible to run against. [^inventory]

## Objective
- Understand the core componenets of Ansible
	- Inventories


### Useful Commands

* ansible-inventory --list --yaml
* ansible-inventory --graph


### Useful Packages
- nmap

### Walkthrough

```zsh
nmap -Pn -p 22 192.168.56.0/24 --open -oG - | awk '/Status/{ print $2 }' | tee inventory
```
- What this command means:
	- nmap - network exploration tool and security / port scanner
	- -Pn  - treat all hosts as online (skip host discover). For speed
	- -p 22 - port 22
	- 192.168.56.0/24 - scan this ip (change to your IP)
	- --open - only show open ports
	- -oG - greppable output
	- "-" - set the ouput/filespec (not exactly sure)
	- | - pipe into..
	- awk - pattern scanning and processing language
	- '/Status/{ print $2 }' - scan for Status and print the second column
	- | - pipe into..
	- tee - read from stdin and write to stdout and files
	- inventory the name of the file



















---
[^inventory]: Quote from [Ansible Docs](https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html)

