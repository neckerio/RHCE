# RHCE
Objectives from [RedHat](https://www.redhat.com/en/services/training/ex294-red-hat-certified-engineer-rhce-exam-red-hat-enterprise-linux-8) [^note]
1. Be able to perform all tasks expected of a Red Hat Certified System Administrator
	- [ ] Understand and use essential tools
	- [ ] Operate running systems
	- [ ] Configure local storage
	- [ ] Create and configure file systems
	- [ ] Deploy, configure, and maintain systems
	- [ ] Manage users and groups
	- [ ] Manage security

2. Understand core components of Ansible
	- [x] [Inventories](Objective_2/Inventories)
	- [x] [Modules](Objective_2/Modules)
	- [ ] Variables
	- [ ] Facts
	- [ ] Plays
	- [ ] Playbooks
	- [x] [Configuration files](Objective_2/Configuration)
	- [ ] Use provided documentation to look up specific information about Ansible modules and commands
	
3. Install and configure an Ansible control node
	- [ ] Install required packages
	- [x] [Create a static host inventory file](Objective_2/Inventories)
	- [x] [Create a configuration file](Objective_2/Configuration)
	- [x] [Create and use static inventories to define groups of hosts](Objective_2/Inventories)
	- [ ] Manage parallelism
	
4. Configure Ansible managed nodes
	- [x] [Create and distribute SSH keys to managed nodes](Objective_4)
	- [x] [Configure privilege escalation on managed nodes](Objective_4)
	- [x] [Validate a working configuration using ad hoc Ansible commands](Objective_4)
	
5. Script administration tasks
	- [ ] Create simple shell scripts
	- [ ] Create simple shell scripts that run ad hoc Ansible commands

6. Create Ansible plays and playbooks
	- [ ] Know how to work with commonly used Ansible modules
	- [ ] Use variables to retrieve the results of running a command
	- [ ] Use conditionals to control play execution
	- [ ] Configure error handling
	- [ ] Create playbooks to configure systems to a specified state

7. Use Ansible modules for system administration tasks that work with:
	- [ ] Software packages and repositories
	- [ ] Services
	- [x] [Firewall rules](Objective_7/Firewall)
	- [ ] File systems
	- [x] [Storage devices](Objective_7/Storage)
	- [ ] File content
	- [ ] Archiving
	- [ ] Scheduled tasks
	- [ ] Security
	- [ ] Users and groups

8. Work with roles
	- [ ] Create roles
	- [ ] Download roles from an Ansible Galaxy and use them

9. Use advanced Ansible features
	- [ ] Create and use templates to create customized configuration files
	- [ ] Use Ansible Vault in playbooks to protect sensitive data
---
[^note]: As with all Red Hat performance-based exams, configurations must persist after reboot without intervention.
