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

5. used in [Security](Objective_7/Security)
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
6. used in managing [Users and Groups](Objective_7/Users)
* user:
	* append:
	* group:
	* groups:
	* home:
	* name:
	* password:
	* password_expire_max:
	* password_expire_min:
	* remove: BOOL
	* shell:
	* ssh_key_comment:
	* ssh_key_file: /path
	* state:
	* generate_ssh_key: BOOL
	* force: BOOL
* group:
	* name:
	* gid:
	* state: p/a
	* system: BOOL
* authorized_key:
	* comment:
	* key: "{{ lookup('file','/path') }}"
	* path: (auth key file on remote nodes)
	* state:
	* user:
* known_hosts: (hopefully, useless)
	* path: (definitive)
	* state: p/a
	* name: host1.example.com
	* key: host1.example.com ssh-rsa 
7. used in [Archiving](Objective_7/Archive)
* archive:
	* dest:
	* force_archive:
	* format: (gz,bz2,tar,xz,zip)
	* group:
	* mode:
	* owner:
	* path:
	* remove: (after adding to archive)
	* exclude_path:
	* exclude_patterns:
* unarchive:
	* creates: (if specified path already exists do **NOT** create)
	* dest: /absolute/path/unpack
	* group:
	* keep_newer: BOOL
	* list_files: BOOL
	* mode:
	* owner:
	* remote_src: BOOL
	* src:
	* include:
	* exclude: item1,item2,item3
7. used in [Scheduled Tasks](Objective_7/Scheduled_Tasks)
* cron:
	* backup: BOOL
	* day:
	* disabled: BOOL
	* hour:
	* job: 
	* minute:
	* month:
	* name: (description)
	* reboot: (run on reboot) BOOL
	* special_time: (hourly, reboot, weekly etc)
	* user: (whose crontab?)
	* weekday:
* at:
	* command:
	* count: (# of units in the future to exec cmd)
	* script_file:
	* state: p/a
	* units: (minutes, hours, day, week)
	* unique: BOOL
8. used in [Facts](Objective_7/Facts)
* debug:
	* msg:
	* var:
* setup:
	* filter:
		* ansible_all_ipv4_addresses (for virtualbox two)
		* ansible_all_ipv6_addresses (for virtualbox three)
		* ansible_default_ipv4
		* ansible_default_ipv6
		* ansible_NETWORK-DEVICE
		* ansible_interfaces


		* ansible_device_links (partition uuid/labels/~hardware)
		* ansible_devices (partition sizes/uuids/labels)
		* ansible_mounts


		* ansible_date_time
		* ansible_env (environment)
		* ansible_hostname
		* ansible_fqdn
		* ansible_nodename
		* ansible_pkg_mgr
		* ansible_python
		* ansible_service_mgr
		* ansible_selinux


		* ansible_user_dir
		* ansible_user_gecos
		* ansible_user_id
		* ansible_user_gid
		* ansible_user_shell


		* ansible_os_family
		* ansible_distribution
		* ansible_distribution_major_version
		* ansible_distribution_release
		* ansible_version


		* ansible_kernel
		* ansible_kernel_version


		* ansible_memfree_mb
		* ansible_memory_mb (RAM)
		* ansible_memtotal_mb
		* ansible_swapfree_mb
		* ansible_swaptotal_mb
9. used in [Variable Results](Objective_6/Variable_Results)
* loop:
	* "{{ variable }}"
	* - list
* register:
* handlers
	* notify:
10. used in [Conditions](Objective_6/Conditionals)
* when:
* changed_when:
11. used in [Error_Handling](Objective_6/Error_Handling)
* block:
	* rescue:
	* always:
* fail:
* failed_when:
* ignore_fails:
* force_handlers:
* any_errors_fatal:

12. used in [ACLs](Extra/ACL)
* acl:
	* path:
	* default: BOOL
	* entity:
	* etype:
	* permissions: (rwx)
	* recursive: BOOL
	* state: (a/p query)
 



---
[^modules]: quote taken from [Ansible Docs](https://docs.ansible.com/ansible/latest/user_guide/modules_intro.html)
