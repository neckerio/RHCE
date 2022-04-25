# Manage Security (RHCSA)

## Objective
* Be able to perform all tasks expected of a Red Hat Certified System Administrator
	* Manage security

---

## RHCSA NOTES:

### Useful Information
* _t is context type (which type of operations allowed on an object. Probably most useful for rhcsa)
* _u is the user (user specific context)
* _r is the role (role specific context)
* when you copy a file it will get new context based on new location
* SELinux uses auditd
* AVC = Access Vector Cache, how selinux messages auditlog



### Useful Commands
* journalctl -t settroubleshoot
* getenforce
* setenforce 1 (enforcing); setenforce 2 (permissive)
* semanage permissive -a http_t (to set permissive on an individual domain)
* sestatus (return status and policy in use)
* fixfiles -F onboot (to create a script to  auto relabel contexts when changing from permissive/enforcing on boot time)
* ausearch -m (message)
* ausearch -m AVC,USER_AVC,SELINUX_ERR,USER_SELINUX_ERR -ts today
* grep "SELinux is preventing" /var/log/messages
* dmesg | grep -i -e type=1300 -e type=1400 (if auditd isn't running)

* SELinux Boot params:
	* enforcing=0
	* selinux=0 (not recommended)
	* autorelabel (forces system relabel)

* CONTINUE NOTES HERE, AT USEFUL COMMANDS!





### Useful Directories/Files
* /etc/sysconfig/selinux
* /etc/selinux/config (basic options) 
* /var/log/audit/audit.log (first check for more info about SELinux denials. ausearch) 
* /var/log/messages (sealerts also show up here. |grep preventing)
* /etc/selinux/fix-files_exclude_dirs (excuded from fixfiles)
* /usr/share/doc/kernel-doc-VERSION/Documentation/admin-guide/kernel-parameters.txt
 

### Useful Packages
* selinux-policy-targeted
* libselinux-utils
* policycoreutils
* settroubleshoot-server (to grep messages to view actions SELinux denies)
* kernel-doc (additional SELinux related boot parameters)
* setools-console (seinfo command)
* selinux-policy-devel (get clearer/detailed description of SELinux booleans in the output of semanage)
* udica (generate SELinux policies for containers)
* rhel-sytem-roles (set of interfaces for unified system management across computers)


---

## Notes
