# Configure Remote Nodes

---

## Objective
* Configure Ansible managed nodes
	*  Create and distribute SSH keys to managed nodes
	*  Configure privilege escalation on managed nodes
	*  Validate a working configuration using ad hoc Ansible commands

### Implementation
* [user.yml](user.yml)
* [deluser.yml](deluser.yml)

### Useful Modules
* user:
	* append: BOOL(no, will remove from other groups, except those listed)
	* comment: GECOS
	* create_home: BOOL (def: true)
	* expires: FLOAT (when account epxires)
	* force:  BOOL (ssh-keys, overwrite) (user, delete all assoc. files)
	* generate_ssh_key: BOOL
	* group: (primary)
	* groups: ('' remove from all except primary)
	* home: (set user home dir /path)
	* move_home: BOOL (move homeidr)
	* name: 
	* password:
	* password_expire_max: (between pw change)
	* password_expire_min:
	* remove:
	* shell:
	* skeleton:
	* ssh_key_comment:
	* ssh_key_file: (name)(default = .ssh/id_rsa)
	* ssh_key_passphrase: (default empty)
	* ssh_key_type:
	* state: present/absent
	* system: (make the user a sys account)
	* uid: 
	* update_password: (always = if they differ?)(on_create = new users)
* authorized_key:
	* comment:
	* key: "{{ lookup('file', '/home/ansible/id_rsa.pub') }}"
	* key_options:
	* path: (default = ~/.ssh/authorized_keys)(remote node)
	* state:
	* user: (on remote node)
* file:
	* group:
	* mode:
	* owner:
	* path:
	* recurse: (if directory)
	* src: (for links)
	* state:
		* absent
		* directory (-p implicit)
		* file (modified OR state of path)
		* touch (create file)
		* hard (hard link)
		* link (symbolic)
		* src (for links)
* blockinfile:
	* backup: BOOL
	* block:
	* create:
	* group:
	* insertafter:
	* insertbefore:
	* mode:
	* owner:
	* path:
	* state:
	* validate:



### Useful Commands
* ansible all -m shell -a "cat /etc/passwd; vdir /etc/sudoers.d"

### Useful Directories/Files
* /etc/sudoers.d/

---

## Notes
1. **user:** module's attribute **password:** can be accomplished in different ways. Examples below use the password _vagrant_ for consistency and clarity.
	1. password_hash[^password_hash] filter option
{{ 'vagrant' | password_hash('sha512','randomsalt') }} 
	2. openssl

```
USER_PASSWORD=$(openssl passwd -6 vagrant)
echo $USER_PASSWORD
ansible all -m user -a "name=ansible password=$USER_PASSWORD"
getent passwd
sudo getent shadow
	3. Quick and dirty shell command[^sander]
echo vagrant | passwd ansible --stdin
```


2. ***authorized_key:*** modue's attribute **key:** requires the use of a **lookup** plugin
	1. The **lookup** plugin CAN'T read hidden files, this is why they are moved to the user's homedir in the playbook.
	2. The SSH keys require secure permissions on the private key, public key and the directory they are in. This is why they are changed in the playbook.

---
[^password_hash]: taken from [Ansible Docs](https://docs.ansible.com/ansible/latest/user_guide/playbooks_filters.html#hash-filters) and [FAQ](https://docs.ansible.com/ansible/latest/reference_appendices/faq.html#how-do-i-generate-encrypted-passwords-for-the-user-module)
[^sander]: taken from [Sander Van Vugt's Videos](https://www.oreilly.com/library/view/red-hat-certified/9780135987513/)
