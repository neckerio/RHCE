# Software packages and Repositories

## Objective
* Use Ansible modules for system administration tasks that work with:
	* Software packages and repositories

---

### Implementation
* [package.yml](package.yml)
* [delpackage.yml](delpackage.yml)

### Useful Modules
* dnf:
	* name:
	* state:
	* update_cache: BOOL
	* update_only: BOOL
	* download_only: BOOL
	* download_dir: /path
	* enablerepo:
	* disablerepo:
	* disable_gpg_check:
* yum_repository:
	* name:
	* state:
	* enabled: BOOL
	* file: (w/o .repo)
	* baseurl:
	* description: (ini [name])
	* gpgcheck: BOOL
* redhat_subscription
	* username:
	* password:
	* state:
* rhsm_repository:
	* name:
	* purge: BOOL (careful, or maybe exactly what is needed)
	* state: (present/enabled/absent/disabled)
* package_facts:
	* (returns package details as facts, read doc)
* rhn_register:
	* (here for posterity)
* rhn_channel:
	* (here for posterity)

### Useful Commands
* subscription-manager config --rhsm.manage_repos=0
* subscription-manager register --username=USERNAME --password=PASSWORD
* subscription-manager --available
* subscription-manager --attach --pool=POOLID
* subscription-manager repos --list
* subscription-manager repos --enable REPONAME
* dnf config-manager --dump (list current config option)
* dnf config-manager --add-repo ADDRESS
* dnf config-manager --set-enabled REPO
* dnf config-manager --set-disabled REPO
* dnf repoinfo
* dnf repolist

### Useful Directories/Files
* /etc/rhsm/rhsm.conf
* /etc/yum.repos.d/
* /etc/vsftpd/vsftpd.conf
* man vsftpd.conf

### Useful Packages
* createrepo
* vsftpd
* lftpd

---

## Notes
1. The following commands can be used to disable the rhsmcertd created repository "redhat.repo"
	* subscription-manager config --rhsm.manage_repos=0
	* or edit /etc/rhsm/rhsm.conf and set ***manage_repos*** to _0_
2. If RHSM is a nightmare as it tends to be, the following is a long and tedious process to get the appstream and baseos from RHSM and turn it off:
	1. turn it on, then repolist to get all repos (this may be the problem, but..)
	2. cp repolist redhat.repo (use absolute paths IMPORTANT) to redhat.bak
	3. use one of the commands above to turn off rhsm
	4. use a SHELL module to get the repos I want (appstream/baseos-rpms), ABSOLUTE PATHS AGAIN, IMPORTANT (otherwise it tees into the homedir by default)
---

```zsh
cat /etc/yum.repos.d/redhat.bak | grep -E -A12 "*baseos-rpms*" | sudo tee > /etc/yum.repos.d/local.repo
```

```zsh
cat /etc/yum.repos.d/redhat.bak | grep -E -A12 "*appstream-rpms*" | sudo tee > /etc/yum.repos.d/local2.repo
```
---




	5. these scripts can probably be cleaned up, grep w/o cat, maybe I don't even need to TEE depending on whether **become* gives a sudo shell. I can even just append >> the appstream to the same _local.repo_ file, BUT this works at the moment and I'm ***MANY EXPLETIVES DELETED from notes***

3. **dnf:** module's attribute ***download_only:*** apparently only works with packages that aren't installed yet; unable to get rpms for installed pacakges.
