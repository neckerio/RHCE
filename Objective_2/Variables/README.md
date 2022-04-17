# Variables

>Ansible uses variables to manage differences between systems. With Ansible, you can execute tasks and playbooks on multiple different systems with a single command. You can define these variables in your playbooks, in your inventory, in re-usable files or roles, or at the command line. You can also create variables during a playbook run by registering the return value or values of a task as a new variable. 
[^variables]

## Objective
* Understand core components of Ansible
	* Variables

---

### Useful Commands
*  ansible-playbook update.yml -e VARS

### Useful Modules
* my_var_path: /path/to/file (simple variable)
	* dest: '{{ my_var_path }}'
 
* region: (list variable)
	- - northeast
	- - southwest
	- - north_by_northwest
	* region "{{ region[0] }}
	 
* foo: (dictionary variable)
	* fieldone: one
	* fieldtwo: two
	* foo['fieldone']

* register:

### Useful Directories/Files

### Useful Packages

---

## Notes
1. Ansible allows Jinja2 Loops and Conditionals in templates but not in playbook
2. Only quote variables when they start an expression
3. Inside a template, you automatically have access to all variables in scope for a host, plus and registered variables, facts and magic variables


---
[^variables]: quoted from [Ansible Docs](https://docs.ansible.com/ansible/latest/user_guide/playbooks_variables.html)
