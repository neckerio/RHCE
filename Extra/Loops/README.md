# Loops, loop control and maybe ansible_facts and hostvars

## Objective EXTRA
	* Loop over different items, maybe without plugins
	* cover loop_control
	* discover if there is a better way to access ansible_facts/hostvars

---

### Implementation
* [testing.yml](testing.yml)

### Useful Information

### Useful Modules
* template:
* register:

### Useful Commands

### Useful Directories/Files

### Useful Packages

---

## Notes
1. This page is closely tied to the templates directory
2. **register:** module with **loop:**, the data structure placed in the variable will contian a __restults__ attribute that is a list of all the responses from the module, this differs from the data structure returned when using register without a loop. [^loopreg]
 

---
[^loopreg]: taken from [Ansible Docs](https://docs.ansible.com/ansible/latest/user_guide/playbooks_loops.html#registering-variables-with-a-loop)

