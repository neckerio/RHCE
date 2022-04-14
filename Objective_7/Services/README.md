# Services

## Objective
* Use Ansible modules for system administration tasks that work with:
	* Services

---

### Implementation
* [service.yml](service.yml)
* [delservice.yml](delservice.yml)

### Useful Modules
* service:
	* enabled: BOOL
	* name:
	* state:
		* started
		* stopped
		* restarted
		* reload

### Useful Commands
* ansible all -a "systemctl list-units --type service --all"
* ansible all -a "systemctl list-dependencies SERVICE"
* anisble all -a "systemctl list-dependencies SERVICE --before"
* anisble all -a "systemctl list-dependencies SERVICE --after"
* ansible all -a "systemctl list-units"
* ansible all -a "systemctl list-units --type target"
* ansible all -a "systemctl help SERVICE"
* ansible all -a "systemctl cat SERVICE"
* ansible all -a "systemctl get-default"
* ansible all -a "systemctl set-default"
* ansible all -a "systemctl isolate xxx.target"
* ansible all -a "systemctl mask SERVICE"
* ansible all -a "systemctl unmask SERVICE"
* ansible all -a "systemd-cgls"
* ansible all -a "systemd-cgtop"
* ansible all -a "systemd-analyze"
* ansible all -a "systemd-analyze blame"
* ansible all -a "systemd-analyze critical-chain"

### Useful Directories/Files
* /usr/lib/systemd/system/
* /run/systemd/system/
* /etc/systemd/system
* /etc/systemd/system.conf
* /etc/systemd/system/default.target (default target)
* /sys/fs/cgroup
* man 5 systemd.unit
* man 5 systemd.service
* man 5 sshd_config
* /var/log/journal (must be created for persistent journaling)
* man 7 systemd.journal-fields

### Useful Packages

---

## Notes
1. vsfptd is a service which can not be reloaded, apparently.
