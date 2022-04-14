# Firewalld

## Objective
* Use Ansible modules for system administration tasks that work with:
	*  Firewall rules

---

### Implementation
* [firewalld.yml](firewalld.yml)
* [delfirewalld.yml](delfirewalld.yml)

### Useful Modules
* Firewalld
	* immediate: BOOL
	* interface:
	* permanent: BOOL
	* port: (port/protocol)
	* service:
	* source: (network to add/remove)
	* state:
		* enable (setting/port)
		* disable (setting/port)
		* present (zones only)
		* absent (zones only)
	* target:
	* zone: (public, block, dmz, drop, external, home, internal, trusted, work)

### Useful Commands
* ansible all -a "firewall-cmd --reload"
* ansible all -a "firewall-cmd --get-services"
* ansible all -a "firewall-cmd --list-services"
* ansible all -a "firewall-cmd --list-all"
* ansible all -a "firewall-cmd --get-active-zones"
* ansible all -a "firewall-cmd --list-all-zones"

### Useful Directories/Files
* man 5 firewalld.zones
* man 5 firewalld.richlanguage
* /usr/lib/firewalld/services (predfined services, --get-services)
* /etc/firewalld/services (define neew services)

### Useful Packages
* vsfptd
* httpd
* nginx

---

## Notes

1. **firewalld:** can only operate one of the following attributes at a time
	* **port:**
	* **service:**
	* ***rich_rule:***
	* **masquerade:**
	* ***icmp_block:***
	* ***icmp_block_inversion:***
	* **interface:**
	* **source:**
2. creating a custom zone requires a --reload for it to become visible and modifiable
