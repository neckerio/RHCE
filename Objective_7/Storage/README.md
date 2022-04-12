# Storage devices

## Objective 
* Use Ansible modules for system administration tasks that work with:
	* Storage devices

### Implementation
* storage_gpt.yml

### Useful Modules
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
	  

### Useful Commands
* ansible all -m setup -a "filter=ansible_devices"
* ansible all -a "mount"
* ansible all -a "findmnt"
* ansible all -a "lsblk --fs"
* ansible all -a "blkid"
* ansible all -m shell -a "pvs;vgs;lvs"

### Useful Directories/Files
* /etc/fstab

---

## Notes

1. **parted:** module's attribute **state:** is required.
2. **parted:** module's attribute **flags:** is required for LVM.
3. **lvol:** module's attribute **size:** only accepts K,M,G. NO ~~KiB,MiB,GiB~~
4. **filesystem:** module's device path attribute is the ONLY one labeled **dev:**
5. **XFS** filesytems can grow but they can't shrink. 
