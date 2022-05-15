# Collections

## Objective Extra
* play around with collections so as not to forget

---

### Implementation

### Useful Modules

### Useful Commands
* ansible-galaxy collection install my_namespace.my_collection
* ansible-galaxy collection install my_namespace-my_collection-1.0.0.tar.gz -p ./collections (tarballs)
	* When using the -p option to specify the install path, use one of the values configured in COLLECTIONS_PATHS, as this is where Ansible itself will expect to find collections.
* ansible-galaxy collection install my_namespace.my_collection --upgrade (upgrade)
* ansible-galaxy collection install my_namespace.my_collection:==1.0.0-beta.1 (diff version)

### Useful Directories/Files

### Useful Packages

---

## Notes
1. Collections are a distribution format for Ansible content that can include playbooks, roles, modules, and plugins. As modules move from the core Ansible repository into collections, the module documentation will move to the collections pages. [^collections]
2. The Collection Index is in the Documentation
3. Collections can be installed and used through Ansible Galaxy

---
[^collections]: Taken from [Ansible_Docs](https://docs.ansible.com/ansible/latest/user_guide/collections_using.html)
