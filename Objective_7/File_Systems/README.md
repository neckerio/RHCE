# File Systems

## Obective
* Use Ansible modules for system administration tasks that work with:
	* File systems

---

### Implementation
* [filesystem.yml](filesystem.yml)
* [delfilesystem.yml](delfilesystem.yml)

### Useful Modules
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

### Useful Commands
* ansible all -a "lsblk --fs"
* swapon -L LABEL
* swapoff -L LABEL

### Useful Directories/Files
* /etc/fstab

### Useful Packages

---

## Notes
1. **filesystem:** module may need the attribute **force:** applied to write over any previously partially deleted filesystems
2. **mount:** module doesn't have mounting capabilities for _swap_. The workaround is to run a separate **command:** module with swapon/swapoff -L LABEL

