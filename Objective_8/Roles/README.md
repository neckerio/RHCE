# Work with roles

## Objective
* Work with roles
	* Create roles
	* Download roles from an Ansible Galaxy and use them

---

## Implementation
- selinux with vsftpd
- make playbook that downloads the reqs first
- calls roles
- use roles to replace plays of selinux
- rhce notes has a collections example, for posix even

## Useful Information
* ROLES, overview of subdirectory:
	* defaults, default vars that may be overwritten by other vars
	* files, static files that are needed by task roles
	* handlers, HANDLERS for use in this ROLE
	* meta, metadata, like dependencies, licence and maintainer info
	* tasks, Role Task definitions
	* templates, Jinja2 templates
	* tests, optional Inventory, and test.yml file to rest the role
	* vars, VARs that aren't meant to be overwritten
* When ROLES are included in a PLAYBOOK, the order of execution is not changed:
	* (ROLES)> TASKS > HANDLERS
* Execute TASKS before ROLES, place Tasks in a pre_tasks section
* Execute Tasks AFTER Roles, other Tasks and Handlers, place Tasks in a post_tasks section
* All that you need to include in a role:
	* tasks/main.yml
	* meta/main.yml



## Useful Modules
* roles: (added in - name:, hosts:, area)
	* - role: ROLE_NAME (Useful Directories/Files lists places to seach)
	* VARS are included a further shift under - role:
		* key: value

## Useful Commands
* ansible-galaxy role init
* ansible-galaxy role search STRING
	* Filters for search
		* platforms
		* author
		* galaxy-tags
* ansible-galaxy role info
* ansible-galaxy role install
* ansible-galaxy role list (installed roles)
* ansible-galaxy role remove
* ansible-galaxy -r requirements.yml
* rpm -ql rhel-system-roles

* ansible-galaxy collection install
* ansible-galaxy collection build
* ansible-galaxy collection download
* ansible-galaxy collection list
	* ansible-doc -l | grep STRING


## Useful Directories/Files
* ./roles current project directory
* ~/.ansible/roles (default download. Can be changed in ansible.cfg)
	* [defaults]
	* roles_path = /path/to/roles
* /etc/ansible/roles
* /usr/share/ansible/roles/ (where rhel/linux-system roles are stored)

## Useful Packages
* tree
* rhel-system-roles (appstream)
	* rhel-system-roles.kdump, configure kdump crash recov service
	* rhel-system-roles.network, configure network interfaces
	* rhel-system-roles.postfix, configure host as mail transfer agent
	* rhel-system-roles.selinux, manages SELinux settings
	* rhel-system-roles.storage, configures storage
	* rhel-system-roles.timesync, configures time synchronization
	* rhel-system-roles.firewall, configures a firewall
	* rhel-system-roles.tuned, configures the tuned service
* linux-system-roles


---

## Notes
1. IMPORTANT: be sure to check the meta/requirements.yml in Roles. This is especially true for rhel-system-roles.selinux and linux-system-roles.selinux. It will not run otherwise.
