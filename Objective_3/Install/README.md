# Install Required Packages

## Objective
* Install and configure an Ansible control node
	*  Install required packages

---

### Implementation

### Useful Modules

### Useful Commands
* sudo dnf repolist
* sudo dnf repoinfo
* sudo dnf config-manager --add-repo URL
* sudo dnf config-manager --set-enabled REPO (permanent)
* sudo dnf config-manager --set-disabled REPO
* sudo dnf search ansible -v
* sudo dnf search ansible --enablerepo REPO (singular)
* sudo dnf search ansible --disablerepo REPO
* sudo dnf search ansible --repo REPO (singular)


* INSTALL using PIP3:
* pip3 install ansible (error)
* pip3 install -U pip (man pages - upgrading pip)
* sudo pip3 install -U pip
* pip3 install ansible
* alternatives --set python /usr/bin/python3


* INSTALL from RHEL8 REPO:
* subscription-manager repos --list | grep -A5 ansible
* subscription-manager repos --enable=ansible-2.8-for-rhel-8-x86_64-rpms
* dnf install -y ansible; ansible --version (verify)


* epel-release
* dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
* ALT ALT EPEL-RELEASE used by CentOS works?
* sudo dnf install -y epel-release


### Useful Directories/Files
* /etc/hosts
* /etc/yum.repos.d/

### Useful Packages
* ansible
* python3
* tmux

---

## Notes
1. Ansible can be install using EPEL or PIP
2. PIP3 is installed with Python3
3. PIP3 fails the first time and then accepts the upgrade with sudo


---
