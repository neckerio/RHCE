# Manage Security (RHCSA)

## Objective
* Be able to perform all tasks expected of a Red Hat Certified System Administrator
	* Manage security

---

## RHCSA NOTES: SELinux

### Overview
* Kernel > enabled/disabled > ---- enabled > enforcing/permissive

### Useful Information
* _t is context type (which type of operations allowed on an object. Probably most useful for rhcsa)
* _u is the user (user specific context)
* _r is the role (role specific context)
* when you copy a file it will get new context based on new location
* SELinux uses auditd
* AVC = Access Vector Cache, how selinux messages auditlog



### Useful Commands
* sestatus (policy)
* getenforce
* setenforce 1 (enforcing); setenforce 2 (permissive)
* semanage permissive -a http_t (to set permissive on an individual domain)

* semanage fcontext -l  (run restorecon after)
* semange fcontext -a -t httpd_sys_content_t "/foo(/.*)?"
* semanage fcontext -a -e /var/www/html /foo (from 1 -> 2)
* semanage port -l
* semanage port -P (persist)
* setsebool -a (list all)
* semanage boolean -l (description)
* semanage boolean -l -C (state different from default)
 

* restorecon -R -v /path/to/target
* chcon -t httpd_sys_content_t2 /var/www/html/index.html
* chcon --reference /var/www/html /var/www/html/index.html
* 
 
* fixfiles -F onboot (to create a script to  auto relabel contexts when changing from permissive/enforcing on boot time)


* ausearch -m MESSAGE
* ausearch -m AVC,USER_AVC,SELINUX_ERR,USER_SELINUX_ERR -ts today
* grep "SELinux is preventing" /var/log/messages
* dmesg | grep -i -e type=1300 -e type=1400 (if auditd isn't running)
* journalctl -t settroubleshoot
* sealert -l LONG#


* ls -Z
* ps Zaux
* 

* SELinux Boot params:
	* enforcing=0
	* selinux=0 (not recommended)
	* autorelabel (forces system relabel)



### Useful Directories/Files
* /etc/sysconfig/selinux
* /etc/selinux/config (basic options) 
* /etc/selinux/targeted
* /etc/selinux/targeted/modules/active = active booleans
* /etc/selinux/targeted/contexts/files/file_contexts (RESTORECON uses)
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

## RHCSA NOTES: Firewalld

### Overview
* Kernel > Netfilter > nftables > firewalld 

### Useful Information
* Components:
	* Service: main, contains 1 or more ports and optional kernel mods to be loaded
	* Zone: default config to which NICS assigned to apply specific settings
	* Ports: optional elements to allow specific ports
	* Additional components available, not used in a base firewall config

### Useful Commands
* firewall-config (GUI)
* firewall-cmd --version
* firewall-cmd --state (check state of firewall)
* firewall-cmd --panic-on (turn off all, DON'T do when on SSH)
* firewall-cmd --panic-off 
* firewall-cmd --query-panic
* firewall-cmd --query-masquerade (check masquerade status)
* firewall-cmd --zone=external --add=masquerade
* firewall-cmd --zone=external --remove=masquerade
* firewall-cmd --list-all-zones
* firewall-cmd --get-active-zones
* firewall-cmd --zone=public --list-all
* firewall-cmd --list-service (list current services)
* firewall-cmd --get-services (list available services)
* firewall-cmd --get-zones (show zones)
* firewall-cmd --get-zone-of-interface=interface
* firewall-cmd --zone=public --list-interfaces
* firewall-cmd --zone=public --add-source=ip.add.re.ss/mask
* firewall-cmd --add-port=8080/tcp
* firewall-cmd --add-port=8080-8888/tcp (add port range)
* firewall-cmd --add-service ftp (add service)
* firewall-cmd --add-service ftp --permanent (permanent but NOT runtime)
* firewall-cmd --reload (reload firewall)
* firewall-cmd --remove-service ftp (--permanent)
* firewall-cmd --zone=internal --remove-service=mdns (remove a specific service from a specific zone)
* firewall-cmd --set-default-zone=home (change default zone)
* firewall-cmd --zone=home --change-interface=eth0 (change interface)
* firwall-cmd --runtime-to-permanent

 
* firewall-cmd --add-rich-rule='rule family=ipv4 service name=ssh log prefix="dropped ssh" level="notice" limit value=5/m drop 


* firewall-cmd --permanent --zone=public --add-forward-port=port=22:proto=tcp:toport=2468
* firewall-cmd --permanent --zone=public --add-forward-port=port=22:proto=tcp:toaddr=192.168.0.200
* firewall-cmd --permanent --zone=public --add-forward-port=port=80:proto=tcp:toport=443:toaddress=192.168.0.211


 

### Useful Directories/Files
* man 5 firewalld.zones
* man 5 firewalld.richlanguage
* /etc/sysconfig/network-scripts/ifcfg-(interface name)
* /usr/lib/firewalld/services (predefined service)
* /etc/firewalld/services/ (define new service)


### Useful Packages
* dnf install firewall-config (interactive, gui if you hate yourself)




---

## Notes
1. start the auditd service
