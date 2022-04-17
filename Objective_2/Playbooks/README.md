# Playbooks

> Playbooks record and execute Ansible’s configuration, deployment, and orchestration functions. They can describe a policy you want your remote systems to enforce, or a set of steps in a general IT process. [^playbooks]

---

## Objective
* Understand core components of Ansible
	* Playbooks
	
### Useful Commands
* ansible-playbook --syntax-check
* echo 'autocmd FileType yaml setlocal ai ts=2 sw=2 et' >> .vimrc
	* **autocmd** - work on opening file 
	* **FileType** - work on these types of files
	* **setlocal** - set only local to current buffer or window
	* **ai** - autoindent
	* **ts** - number of spaces that a tab in the file counts for
	* **sw** - affects how autoindentation works (<< >> == as well)
	* **et** - ensures that tab will actually use spaces
* echo 'alias a=ansible' >> .bashrc
* echo 'alias ap=ansible-playbook' >> .bashrc
* echo 'alias ad=ansible-doc' >> .bashrc
* echo 'alias av=ansible-vault >> .bashrc
* echo 'alias ac=ansible-config >> .bashrc

### Useful Modules
* import_playbook:
	* become: BOOL
	* tags:
* include_playbook:

### Useful Directories/Files
* .bashrc
* .zshrc

### Useful Packages
* ansible
* python3

---

## Notes

[^playbooks]: quoted from [Ansible Docs](https://docs.ansible.com/ansible/latest/user_guide/playbooks.html)
