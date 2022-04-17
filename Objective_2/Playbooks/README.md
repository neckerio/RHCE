# Playbooks

> Playbooks record and execute Ansible’s configuration, deployment, and orchestration functions. They can describe a policy you want your remote systems to enforce, or a set of steps in a general IT process. [^playbooks]

---

## Objective
* Understand core components of Ansible
	* Playbooks
	* Plays
	
### Useful Commands
* ansible-playbook --syntax-check
* ansible-playbook -C (dry run)
* ansible-playbook -vvvv (maximum verbosity)
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
* echo 'alias ai=ansible-inventory >> .bashrc
* echo 'alias ag=ansible-galaxy >> .bashrc

### Useful Modules
* import_playbook:
	* become: BOOL
	* tags:
* include_playbook:

* Literal Block Scalar "**|**" = maintains formatting (newlines)
* Folded Block Scalar "**>**" = treated as one line

### Useful Directories/Files
* .bashrc
* .zshrc

### Useful Packages
* ansible
* python3

---

## Notes
1. Handlers are the same level as **name:**, **hosts:** and **tasks:** (play definition)
2. ***remote_user***, **become:**, ***become_method*** and ***become_user*** can also be defined at the Play Definition.
3. Start with --- and end with ...
4. Importing incorporates playbooks etc. statically; they are executed in order just as if they had been defined in the playbook [^importing]
5. Include, adds playbooks etc. dynamically; so they can be affected by results of earlier tasks in the playbook. Useful when looping, the tasks will be executed once for each loop. [^including]

---

[^playbooks]: quoted from [Ansible Docs](https://docs.ansible.com/ansible/latest/user_guide/playbooks.html)
[^importing]: quoted from [Ansible Docs](https://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse.html#playbooks-reuse)
[^including]: quoted from [Ansible Docs](https://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse.html#playbooks-reuse)
