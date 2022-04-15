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
4. used to [SSH Key Distribution](Objective_4)
* authorized_key:
	* comment:
	* key: "{{ lookup('file', '/home/ansible/id_rsa.pub') }}"
	* key_options:
	* path: (default = ~/.ssh/authorized_keys)(remote node)
	* state:
	* user: (on remote node)
5. used in [File Content Management](Objective_7/File)
* file:
	* group:
	* mode:
	* owner:
	* path:
	* recurse: (if directory)
	* src: (for links)
	* state:
		* absent
		* directory (-p implicit)
		* file (modified OR state of path)
		* touch (create file)
		* hard (hard link)
		* link (symbolic)
		* src (for links)
	* backup: BOOL
* blockinfile:
	* block:
	* create:
	* group:
	* insertafter:
	* insertbefore:
	* mode:
	* owner:
	* path:
	* state: (present/absent)
	* validate:
* stat
	* path:
* find
	* age: (s,m,h,d,w)
	* age_stamp: (atime,ctime,mtime)
	* contains: (regex)
	* excludes: (regex)
	* file_type: (any,directory,file,link)
	* hidden: BOOL
	* paths:
	* size:
* lineinfile
	* backup: BOOL
	* create:
	* firstmatch: (/w insertafter/instertbefore)
	* group:
	* insertafter: (after last match)
	* insertbefore: (before last match)
	* line:
	* mode:
	* owner:
	* path:
	* regex:
	* search_string:
	* state: (present/absent)
	* validate:
* copy:
	* backup: BOOL
	* content:
	* dest:
	* force:
	* group:
	* mode:
	* owner:
	* remote_src:
	* src: (local path)
	* validate:
* fetch:
	* dest: (adds remote host name to avoid conflicts)
	* flat: (override default dest: behavior)
	* src: (file only)
* synchronize
	* archive: BOOL
	* compress: BOOL
	* dest:
	* existing_only: BOOL (don't create new files)
	* group:
	* mode:
	* owner:
	* private_key: (ssh)
	* recursive: BOOL
	* set_remote_user:
	* src:
* replace:
	* after: (replace after this match)
	* backup: BOOL
	* before: (replace before this match)
	* group:
	* mode:
	* owner:
	* path: (file to mod)
	* regexp:
	* replace: (what to replace regex with)
	* validate:
* template:
	* backup: BOOL
	* dest:
	* force:
	* group:
	* mode:
	* owner:
	* src:
	* validate:








---
[^modules]: quote taken from [Ansible Docs](https://docs.ansible.com/ansible/latest/user_guide/modules_intro.html)
