# Configuration files

> Ansible supports several sources for configuring its behavior, including an ini file named ansible.cfg, environment variables, command-line options, playbook keywords, and variables. See Controlling how Ansible behaves: precedence rules for details on the relative precedence of each source. [^configuration]

---

## Objective 
* Understand the core componenets of Ansible 
	* Configuration files

### Useful Commands
* ansible --version
* ansible-config list
* ansible-config view
* ansible-config dump
* ansible-config dump --only-changed

### Useful Packages

### Useful Directories/Files
* /etc/ansible/ansible.cfg
* ~/.ansible.cfg
* ansible.cfg

---

## Walkthrough

1. Populate the [defaults] and [escalation_privileges], at a minimum, in the [ansible.cfg](ansible.cfg) file.

* [defaults]
	* ~~remote_user~~ - user to be logged into on remote host
	* ~~inventory~~ - inventory file
	* ~~host_key_checking~~ - whether to check ssh keys
	* ~~ask_pass~~ - whether playbook should prompt for a login password
	* ~~stdout_callback~~ - configure ansible output
	* ~~deprecation_warnings~~ - toggle deprecation warnings

* [escalation_privileges]
	* ~~become~~ - allows changing users after login
	* ~~become_user~~ - user to become
	* ~~become_method~~ - how privilege escalation is accomplished
	* ~~become_ask_pass~~ - toggle prompt for privilege escalation password


---
[^configuration] quote from [Ansible Docs](https://docs.ansible.com/ansible/latest/reference_appendices/config.html)
