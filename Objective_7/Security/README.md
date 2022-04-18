# Security

## Objective
* Use Ansible modules for system administration tasks that work with:
	* Security

---

### Implementation

### Useful Modules
* selinux:
	* state: 
	* policy: (targeted)
	* configfile:
* seboolean:
	* name:
	* persistent: BOOL
	* state: BOOL
* sefcontext:
	* setype: (public_content_rw_t)
	* target:
	* state: (p/a)
	* reload: BOOL
	* COMMAND: "restorecon -v -R /path/to/file
* seport:
	* ports: (lists and ranges)
	* proto:
	* reload:
	* setype: (ssh_port_t)
	* state: (p/a)
* selinux_permissive:
	* domain: (httpd_t)
	* permissive: BOOL

### Useful Commands
* restorecon -v -R /path/to/file
* getenforce
* setenforce
* getsebool -a
* setsebool httpd_enable_homdirs 1 -P
* semanage boolean -l (learn what bools do) -C (different from default)
* journalctl | grep sealert
* sealert -a /var/log/messages OR /var/log/audit/audit.log
* sestatus
* journalctl -b -0 (everything since boot)
* semanage fcontext -a -t httpd_sys_content_t "/foo(/.*)?"
	* typical change of context type
* semanage fcontext -a -e /var/www/html /foo
	* ALT, add Existing context of 1 to 2
* ls -lZ(d) (for dir)
* ps auxZ | grep
* semanage port -l (-C, for modified)
* semanage port -a -p tcp 8080 -t http_port_t

### Useful Directories/Files
* /var/log/messages (sealert)
* /var/log/audit/audit.log (grep AVC)
* /etc/sysconfig/selinux
* /etc/selinux/targeted/modules/active/
* /etc/selinux/targeted/contexts/files/file_contexts

### Useful Packages
* policycoreutils-python-utils (audit2allow)
* setroubleshoot
* setroubleshoot-server (sealert)

---

## Notes

