#  Use variables to retrieve the results of running a command

## Objective
* Create Ansible plays and playbooks
	*  Use variables to retrieve the results of running a command

---

### Implementation
* [loop_download.yml](loop_download.yml)
* [delloop_download.yml](delloop_download.yml)


### Useful Modules
* loop:
	* "{{ variables }}"
	* - list
* register:
* handlers
	* notify:


### Useful Commands

### Useful Directories/Files

### Useful Packages

---

## Notes
1. **loop:** might require the "{{ variables }}" to be on the same line as the loop itself
2. **loop:** defined at same level as modules
3. **handlers** only run on CHANGED status. 
