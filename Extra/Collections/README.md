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
* ansible-galaxy collection download COLLECTION (download tarball/requirement file)
* ansible-galaxy collection list (list installed collections)
* ansible-galaxy collection verify (verify collection is the same as that on the server)
* 

### Useful Directories/Files

### Useful Packages

---

## Notes
1. Collections are a distribution format for Ansible content that can include playbooks, roles, modules, and plugins. As modules move from the core Ansible repository into collections, the module documentation will move to the collections pages. [^collections]
2. The Collection Index is in the Documentation
3. Collections can be installed and used through Ansible Galaxy
4. ansible-galaxy install uses; uses galaxy server listed in ansible.cfg under GALAXY_SERVER
5. ansible-galaxy installs in path COLLECTIONS_PATHS
6. collections requirement file example:

```yaml
---
collections:
# With just the collection name
- my_namespace.my_collection
# With the collection name, version, and source options
- name: my_namespace.my_other_collection
   version: 'version range identifiers (default: ``*``)'
   source: 'The Galaxy URL to pull the collection from (default: ``--api-server`` from cmdline)'
```

7. to install both collections/roles on the CMDLINE just remove the specifier; "ansible-galaxy install -r requirements.yml
8. configure multiple servers using GALAXY_SERVER_LIST
9. download a collection and its dependencies for an offline download run "ansible-galaxy collection download".
	* this creates a requirements.yml file which can be used to install those collections on a host without access to an ANSIBLE_GALAXY_SERVER
10. FQCN - fully qualified collection names can be used in playbooks, once installed

```yaml
- hosts: all
  tasks:
    - my_namespace.my_collection.mymodule:
        option1: value
```



---
[^collections]: Taken from [Ansible_Docs](https://docs.ansible.com/ansible/latest/user_guide/collections_using.html)
