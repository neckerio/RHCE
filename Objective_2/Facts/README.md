# Facts

> With Ansible you can retrieve or discover certain variables containing information about your remote systems or about Ansible itself. Variables related to remote systems are called facts. With facts, you can use the behavior or state of one system as configuration on other systems. Variables related to Ansible are called magic variables. [^facts]


## Objective
* Understand core components of Ansible
	* Facts

---

### Implementation
* [facts_loop.yml](facts_loop.yml)
* [facts_loop_specifics.yml](facts_loop_specifics.yml)
* [hashes_lists.yml](hashes_lists.yml)
* [local_vars.yml](local_vars.yml)

### Useful Commands
* INJECT_FACTS_AS_VARS
* ansible all -m setup -a "filter=ansible_all_ipv4_addresses" (for virtualbox two)
* ansible all -m setup -a "filter=ansible_all_ipv6_addresses" (for virtualbox three)
* ansible all -m setup -a "filter=ansible_default_ipv4"
* ansible all -m setup -a "filter=ansible_default_ipv6"
* ansible all -m setup -a "filter=ansible_NETWORK-DEVICE"
* ansible all -m setup -a "filter=ansible_interfaces"


* ansible all -m setup -a "filter=ansible_device_links" (partition uuid/labels/~hardware)
* ansible all -m setup -a "filter=ansible_devices" (partition sizes/uuids/labels)
* ansible all -m setup -a "filter=ansible_mounts"
* ansible all -m setup -a "filter=ansible_lvm"


* ansible all -m setup -a "filter=ansible_date_time"
* ansible all -m setup -a "filter=ansible_env" (environment)
* ansible all -m setup -a "filter=ansible_hostname"
* ansible all -m setup -a "filter=ansible_fqdn"
* ansible all -m setup -a "filter=ansible_nodename"
* ansible all -m setup -a "filter=ansible_pkg_mgr"
* ansible all -m setup -a "filter=ansible_python"
* ansible all -m setup -a "filter=ansible_service_mgr"
* ansible all -m setup -a "filter=ansible_selinux"


* ansible all -m setup -a "filter=ansible_user_dir"
* ansible all -m setup -a "filter=ansible_user_gecos"
* ansible all -m setup -a "filter=ansible_user_id"
* ansible all -m setup -a "filter=ansible_user_gid"
* ansible all -m setup -a "filter=ansible_user_shell"


* ansible all -m setup -a "filter=ansible_os_family"
* ansible all -m setup -a "filter=ansible_distribution"
* ansible all -m setup -a "filter=ansible_distribution_major_version"
* ansible all -m setup -a "filter=ansible_distribution_release"
* ansible all -m setup -a "filter=ansible_version"


* ansible all -m setup -a "filter=ansible_kernel"
* ansible all -m setup -a "filter=ansible_kernel_version"


* ansible all -m setup -a "filter=ansible_memfree_mb"
* ansible all -m setup -a "filter=ansible_memory_mb" (RAM)
* ansible all -m setup -a "filter=ansible_memtotal_mb"
* ansible all -m setup -a "filter=ansible_swapfree_mb"
* ansible all -m setup -a "filter=ansible_swaptotal_mb"


* hostvars [^magic]
* groups
* group_names
* inventory_hostname


### Useful Modules
* ansible_facts['']['']
* gather_facts: False
* set_fact: 
* fact_path:

```zsh
ansible all -m setup -a "filter=ansible_local"
```

```zsh
{{ ansible_local[''][''][''] }}
```


### Useful Directories/Files
* /etc/ansible/facts.d/FILE.fact (INI format)


### Useful Packages

---

## Notes
1. When trying to retrieve ansible_facts, and troubleshooting, pay attention to the structure of the ansible_fact ouput. A common problem is that the attributes that are being accessed are on the same level and can't see each other. 
2. It is also possible to loop for specificity. That is return a loop item in a larger message that will display specifics of each loop item. In implementation.
3. Remember the obvious, item.value works on hashes/dictionaries
4. Local facts and group_vars/host_vars are both displayed as hashes. X_vars are written as hashes and .fact files are in INI format. In implementation


---
[^facts]: quoted from [Ansible Docs](https://docs.ansible.com/ansible/latest/user_guide/playbooks_vars_facts.html)
[^magic]: read up on [magic variables](https://docs.ansible.com/ansible/latest/reference_appendices/special_variables.html#special-variables)

