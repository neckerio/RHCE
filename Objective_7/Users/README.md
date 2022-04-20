# Users and Groups

## Objective
* Use Ansible modules for system administration tasks that work with:
	* Users and groups

---

### Implementation
* [users.yml](users.yml)
* [delusers.yml](delusers.yml)

### Useful Modules
* user:
	* append:
	* group:
	* groups:
	* home:
	* name:
	* password:
	* password_expire_max:
	* password_expire_min:
	* remove: BOOL
	* shell:
	* ssh_key_comment:
	* ssh_key_file: /path
	* state:
	* generate_ssh_key: BOOL
	* force: BOOL
* group:
	* name:
	* gid:
	* state: p/a
	* system: BOOL
* authorized_key:
	* comment:
	* key: "{{ lookup('file','/path') }}" [^authkey] [^mode]
	* path: (auth key file on remote nodes)
	* state:
	* user:
* known_hosts: (hopefully, useless)
	* path: (definitive)
	* state: p/a
	* name: host1.example.com
	* key: host1.example.com ssh-rsa 

### Useful Commands
* getent passwd
* sudo getent shadow
* getent group
* id
* id USER
* sudo passwd USER -S



* to help with yaml format
```zsh
echo "autocmd FileType yaml setlocal ai ts=2 sw=2 et" >> .vimrc; source .vimrc
```


* to help with navigation in vim
```zsh
echo "set number relativenumber" >> .vimrc; source .vimrc"
```


* to help with bash navigation
```zsh
echo "set -o vi" >> .bashrc; source .bashrc
```


* ansible aliases
```zsh
echo "alias a=ansible ap=ansible-playbook ad=ansible-doc" >> .bashrc; source .bashrc
```


### Useful Directories/Files
* /etc/passwd
* /etc/shadow
* /etc/sudoers.d/
* /home/USER/.bashrc
* /home/USER/.vimrc

### Useful Packages
* vim
* tmux

---

## Notes
1. The lookup plugin CAN NOT search through hidden files with /path. SSH keys must be moved somewhere visible to the plugin. An unhidden file/directory
2. SSH keys require specific modes in order for them to be accepted as safe
	* directory = 0755
	* public key = 0644
	* private key = 0600
3. When looping over info.yml, I found that the loop reference "{{ userinfo }}" didn't work when on a separate line than loop with a hyphen. The solution was to just put it on the same line as the loop

---
[^authkey]: reference number one in Notes
[^mode]: reference number two in Notes

