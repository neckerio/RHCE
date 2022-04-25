# Configure Local Storage

## Objective RHCE
* Be able to perform all tasks expected of a Red Hat Certified System Administrator
	* Configure local storage

## Objective RHCSA
* Configure local storage
	* List, create, delete partitions on MBR and GPT disks
        * Create and remove physical volumes
        * Assign physical volumes to volume groups
        * Create and delete logical volumes
        * Configure systems to mount file systems at boot by universally unique ID (UUID) or label
        * Add new partitions and logical volumes, and swap to a system non-destructively
 

---

## Storage:

### Useful Information
* MiB = multiple of 1024 = Mebibyte (comes from Binary)
* MB = multiple of 1000  = Megabyte
* GPT for EFI boot or legacy beyond 2 terabytes
* MBR BIOS or below 2 terabytes
* MBR BIOS uses extended partitions for 4 and places logical partitions on top
* extended partitions are read in order: first is #5, if you delete #5 then it may confuse /etc/fstab which is now reading #6 as the first extended partition. Use a Label or UUID
* if you use gdisk on an fdisk it will give you a warning about potential damage
* the "type" option in fdisk is asking for a hexcode, which identifies at an OS level what is happening on a partition
* don't forget to mount swap in /etc/fstab.  Also you mount swap on "swap", without any / because it is interfacing with the kernel.
* a logical volume allows you to more easily resize storage
* a logical volume uses a 3-tier system
	* phsyical volumes (disk, partitions, storage devices)
	* volume groups (collection of all the available storage)
	* logical volume (create a filesystem and mount)
* technically pvcreate is optional
* xfs can be increased but not decreased
* ext4 can be increased and decreased
* Stratis = next generation volume managing filesystem that uses thin provisioning by default. It is implemented in user space, which makes api access possible
* VDO = focused on storing files in the most efficient way, manages deduplicated and compressed storage pools
* the LABEL for storage is made ON the FileSystem


### Useful Commands
* parted (apparently the RHEL standard now, others still work fine)
* fdisk (MBR)
* gdisk (GPT)
* partprobe (to update storage)
* lsof (list open files, umount says Filesystem is Busy)
* findmnt (filesystem view of mounts)
* xxd -l 512 /dev/xxx (make a hexdump or do reverse)
* mkswap /dev/xxx (to make swap)
* swapon /dev/xxx (to mount swap)
* free -m (display amount of free and used memory)
* mkfs.ext4 -L myLabel /dev/xxx (label file system)
* blkid (display block devices with their properties)
*  lsblk --fs
* tune2fs -L labelName /dev/sdxx (make a label on an ext4 fs)
*  e2fs /dev/vgdata/lvdata - will display labelname
* xfs_admin -L (make a label on xfs fs, RHEL)
* labels can be used in /etc/fstab etc.
* systemctl status tmp.mount (systemd mounting)
* xfsdump (create backups of xfs formatted devices)
* xfsrestore (restore backup made with xfsdump)
* xfsrepair (repair broke xfs fs)
* pv (physical volume, tab tab it for options)
* vg (volume gorup, tab tab it for options)
* lv (logical volume, tab tab it for options)
* fdisk -l 
* lvs (display information about logical volumes)
* df -h (report filesystem disk space usage, human-readable)
* vgs (display information about volume group)
* vgextend (add space to volume group)
* lvextend (add space to logical volume)


### Useful Directories/Files
* cat /proc/partitions (kernel view)
* /dev/disk (other ways to identify storage/partitions)
* /usr/lib/systemd/system/tmp.mount (systemd mount example)
* /etc/systemd/system/* (where user made files should be placed)
	* the name MUST be identical to where it is mounted (/articles = articles.mount IF it is a subdirectory you need to add "-" data-articles.mount)


### Useful Packages
* vim-common (xxd command)

---

## Advanced Storage

### Useful Information
* LVM used RHEL default and adds flexibility (resize, snapshots etc)
	* physical vol > volume group > logical vol > filesystem
* dev/volgrp/logvol
* Device Mapper is the system the kernel uses to interface with storage
* shrinking not possible on XFS only extending
* Stratis volume managing fs uses thin provisioning
	* need a filesystem on top of Stratis (XFS only option)
	*  built on any block device (at least 1GiB)
	* partitions NOT supported
	* Stratis pool created from 1 or more devices(blockdev)
	* creates /dev/stratis/my-pool dir for each pool
		* this dir contains links to devices that reprsent FS in the pool
	*  block devices in pool may not be thin provisioned
	* each pool can contain 1 or more file systems
	* no fixed size, automatically grows as more data is added to fs
* a snapshot is an individual fs that can be mounted
	* needs at least half a gigabyte storage for xfs log
* Virtual Data Optimizer manages deduplicated and compressed storage pools. efficient
	* provides thin provisioned storage
	* use logical size 10x the phys size for VMs and containers
	* use logical size 3x this phys size for object storage 
	* used in cloud and container environments
	* it manages deduplicated and compressed storage pools in RHEL8
	* underlying block devices need to be bigger than 4GiB
	* mkfs.xfs -K needed! stands for discard, without it will take forever
	* /etc/fstab needs:
		* x-systemd.requires=vdo.service discard (mount option)
	* can be created on top of partition
* LUKS Encrypted Device
	* to automate cryptsetup luksOpen use /etc/crypttab
	* to automate mounting the volume use /etc/fstab
	* /dev/sdx > cryptsetup luksformat > cryptsetup luksOpen NAME > /dev/mapper/NAME > mkfs.xx > mount


### Useful Commands
* findmnt
* fdisk /dev/xxx; n>l>82?
* pvcreate /dev/sdb1
* vgcreate vgdata /dev/sdb1
* lvcreate -n lvdata -L 1G vgdata
* mkfs.xx /dev/vgdata/lvdata
* mkdir -p /mount/lvm1
	* vim /etc/fstab
	* /dev/vgdata/lvdata /mount/lvm1 xfs defaults 0 0 
* ln -l /dev/vgdata/lvdata /dev/mapper/vgdata-lvdata = same
* pvs (list physical volumes)
* vgs (list volume groups)
* df -h (check avail disk space) 
* lvextend -r (extend including fs)
* lvextend -r -L +1G /dev/vgdata/lvdata
* e2resize (resize ext filesystems)
* xfs_growfs (grow xfs filesystems)
* vgextend (add new physical volume to the group)
* vgextend vgdata /dev/xxx (automatically applies pvcreate)
* systemctl enable --now stratisd
* stratis pool create mypool /dev/sdxx
* stratis blockdev add-data (add new device later)
* stratis fs create mypool myfs1 (XFS automatic)
* stratis fs list mypool (show all filesystems in pool)
* stratis pool list
* stratis filesystem list
* stratis blockdev list mypool 
* stratis pool add-data mypool /dev/sdx (ad another blockdev)
* stratis fs snapshot mypool myfs1 myfs1-snapshot*  mount /stratis/mypool/my-fs-snapshot /mnt (to mount)
* stratis filesystem destroy mypool mysnapshot (delete snap)
* stratis filesystem destroy mypool myfs (destroy filesystem)
* stratis pool destroy mypool (destroy pool when no more fs exist)
* vdo create --name=vdo1 --device=/dev/sdx --vdoLogicalSize2=1T 
* mkfs.xfs -K /dev/mapper/vdo1 (-K needed for VDO)
* udevadm settle (wait for system to register new dev name)
* vdostats --human-readable (monitor) 
* cryptsetup luksFormat (format LUKS device)
* cryptsetup luksOpen NAME (open and create device mapper name)


### Useful Directories/Files
* man vdo (examples)
* /usr/share/doc/vdo/examples/systemd
* /etc/crypttab
* /etc/fstab
* man crypttab


### Useful Packages
* stratisd
* stratis-cli
* vdo (may need a reboot)
* kmod-kvdo (may need a reboot)



## Notes
