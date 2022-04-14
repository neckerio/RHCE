# Modules

> Modules (also referred to as “task plugins” or “library plugins”) are discrete units of code that can be used from the command line or in a playbook task. Ansible executes each module, usually on the remote managed node, and collects return values. In Ansible 2.10 and later, most modules are hosted in collections. [^modules]


---
## Objective
* Understand core components of Ansible
	* Modules

### Useful Commands
* ansible-doc -t module -l | less

### Useful Modules
1. Used in [Storage Management](../../Objective_7/Storage)
* parted:
	* device: /path/to/device
	* label: (gpt,msdos etc.)
	* state: (info, absent, present)
	* unit: (KB/KiB,MB/MiB,GB/GiB) 
	* number: 
	* part_type: (primary, logical, extended)
	* part_start: 
	* part_end
	* flags: ([lvl],[boot],[swap])
* lvg:
	* pvs: /dev/sdb2
	* state: (present/absent)
	* vg:
	* pesize: "4" (physical extent size, multiple of 2)
	* pv_options: (additional options to pass to pvcreate; test)
	* vg_options: (additional options to pass to vgcreate; test)
* lvol:
	* lv:
	* vg:
	* size: (mMgG, 80%VG, 20%PVS)
	* resizefs: BOOL
	* shrink: BOOL (shrinks if current size is larger than requested)
	* pvs: /path/to/pvs
	* state: present/absent (absent removes lv only)
	* force: BOOL (shrink/remove REQUIRES this)
	* opts: (additional options to pass to lvcreate)
	* snapshot: NAME
	* thinpool: NAME
* filesystem:
	* dev:
	* force: BOOL
	* fstype: (ext4,xfs,lvm,swap,vfat,btrfs)
	* resizefs: (grow fs if blockdevice and fs differ; xfs,lvm,ext4,vfat)
	* state: (present/absent)
	* opts: (list of options to pass to mkfs)
* mount:
	* boot: BOOL (fs mounted on boot)
	* fstype:
	* path: /mnt
	* src: (/path, LABEL, UUID)
	* state: 
		* mounted - mounted & placed in fstab
		* unmounted - unmounted (fstab untouched)
		* present - fstab
		* absent - unmount & remove from fstab
		* remounted - remount
	* opts: (options to pass to mount)
	* dump: 0
	* passno: 0 
2. used in [Firewall Management](../../Objective_7/Firewall)
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
3. used in [Service Management](../../Objective_7/Service)
* service:
	* enabled: BOOL
	* name:
	* state:
		* started
		* stopped
		* restarted
		* reload






---
[^modules]: quote taken from [Ansible Docs](https://docs.ansible.com/ansible/latest/user_guide/modules_intro.html)
