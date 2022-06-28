# Storage devices

## Objective 
* Use Ansible modules for system administration tasks that work with:
	* Storage devices

### Implementation
* [storage_gpt.yml](storage_gpt.yml)
* [grow_storage_gpt.yml](grow_storage_gpt.yml)
* [shrink_storage_gpt.yml](shrink_storage_gpt.yml)
* [delstorage_gpt.yml](delstorage_gpt.yml)
* [storage_msdos.yml](storage_msdos.yml)
* [delstorage_msdos.yml](delstorage_msdos.yml)
* [confirm.yml](confirm.yml)

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
3. **parted:** module's attribute **label:msdos** requires some BUFFER space between the partitions.
4. **lvg:**-module-created vgs can leave "legacy" vgs that auto-attach to newly created partitions that correspond to the "legacy" partition. Worthwhile to create a VG delete that can somehow handle this. 
5. **lvol:** module's attribute **size:** only accepts K,M,G. NO ~~KiB,MiB,GiB~~
6. **lvol:** module can be used to _grow_ a volume while mounted, but must unmount the volume to _shrink_ it.
7. **lvol:** module, when used on msdos labeled partition, adds buffer storage. Add a **force:** attribute to help with idempotency
8. **filesystem:** module's device path attribute is the ONLY one labeled **dev:**
9. **filesystem:** module's attribute **opts:** can be used to add a LABEL for mounting in /etc/fstab
10. **XFS** filesytems can grow but they can't shrink. 
11. **mount:** module's attribute **fstype:** required even for deletion.
12. **mount:** module's attribute **src:** can accept a UUID, but note that:
	1. It must be put in a separate Play otherwise it fails because device-mapper cant locate the UUID, I think. If it is in the same Play it will only work if run twice.
	2. the color highlighting gets all screwed up when mounting with a UUID because of the placement of an _=_ next to _""_, but it still works.
	3. Using a shell command, represented below, works on the CMDLINE as an adhoc command, but when run in a playbook the output isn't displayed anywhere. ansible_facts work instead.
```zsh
blkid | awk '/lvthree/{ print $2 }' | cut -d ' ' -f 2
```

13. **mount:** module can not be written to mount a SWAP file using a playbook for some strange reason; However, it can be accomplished using an AD HOC command followed by a SWAPON command. Link on the topic from [Ansible Support.](https://github.com/ansible/ansible/issues/29647). Ansible Playbooks DO work for deleting the SWAP space, however.
```zsh
ansible all -m mount -a 'src=/dev/sdb3 path=none fstype=swap opts=sw state=present'
```

```zsh
swapon -a
```

1. Using the **thinpool:** attribute requires a bit of preperation. Useful steps from [RHEL.](https://blog.purestorage.com/purely-technical/data-reduction-deep-dive-is-thin-provisioning-data-reduction/)
	* use **lvol:** to create a THIN POOL first
		- vg: (name)
		- thinpool: (name)
		- size: 
	* use **lvol:** to creat a THIN VOLUME in the pool defined above
		- vg:
		- lv:
		- thinpool:
		- size:

