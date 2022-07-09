
# Stratis
## Objective Extra
* Review Stratis

---

### Implementation
* [stratis.yml](stratis.yml)
* [delstratis.yml](delstratis.yml)

### Useful Information
* Stratis runs as a service to manage pools of physical storage devices, simplifying local storage management with ease of use while helping you set up and manage complex storage configurations. [^Stratis]
*  Stratis is a hybrid user-and-kernel local storage management system that supports advanced storage features. The central concept of Stratis is a storage pool. This pool is created from one or more local disks or partitions, and volumes are created from the pool. 
* Features:
	* Filesystem Snapshots
	* Thin Provisioning
	* Tiering
* Components of Stratis:
	* **Blockdev** - block devices like disk or partition
	* **Pool** - composed of one or more block devices, with a fixed total size that is equal to the block devices. The pool contains most of the Stratis layers. Pools create a /dev/stratis/POOLNAME which contains links to devices that represent Stratis File Systems in the pool
	* **Filesystem** -  Each pool can contain one or more file systems, which store files.File systems are thinly provisioned and do not have a fixed total size. The actual size of a file system grows with the data stored on it. If the size of the data approaches the virtual size of the file system, Stratis grows the thin volume and the file system automatically.The file systems are formatted with XFS.

*  Stratis tracks information about file systems created using Stratis that XFS is not aware of, and changes made using XFS do not automatically create updates in Stratis. Users must not reformat or reconfigure XFS file systems that are managed by Stratis. 

* 

* Stratis volume managing fs uses thin provisioning
* RHEL answer to btrfs and ZFS	
* need a filesystem on top of Stratis 
	- XFS only option!
* built on any block device (at least 1GiB)
* partitions NOT supported
* Stratis pool created from 1 or more devices(blockdev)
* creates /dev/stratis/my-pool dir for each pool
	- this dir contains links to devices that reprsent FS in the pool
* block devices in pool may not be thin provisioned
* each pool can contain 1 or more file systems
* no fixed size, automatically grows as more data is added to fs
* a snapshot is an individual fs that can be mounted
	- needs at least half a gigabyte storage for xfs log


### Useful Modules

### Useful Commands
* wipefs --all /dev/DEVICE
* lsblk --output=UUID /dev/stratis/POOL/FS
* blkid -s UUID -o value
* systemctl enable --now stratisd
* stratis pool create mypool /dev/sdxx
* stratis blockdev add-data (add new device later)
* stratis fs create mypool myfs1 (XFS automatic)
* stratis fs list mypool (show all filesystems in pool)
* stratis pool list
* stratis filesystem list
* stratis blockdev list mypool 
* stratis pool add-data mypool /dev/sdx (ad another blockdev)
* stratis fs snapshot mypool myfs1 myfs1-snapshot
	- mount /stratis/mypool/my-fs-snapshot /mnt (to mount)
* stratis filesystem destroy mypool mysnapshot (delete snap)
* stratis filesystem destroy mypool myfs (destroy filesystem)
* stratis pool destroy mypool (destroy pool after the FS has been destroyed)


#### create a stratis system
* $ systemctl enable --now stratisd; ssystemctl status stratisd
* $ wipefs --all /dev/DEVICE
* $ stratis pool create mypool /dev/sdx; stratis pool (verify)
* $ stratis fs create mypool myfs1; stratis fs (verify)
* $ mkdir /myfs1; mount /dev/stratis/mypool/myfs1 /myfs1; mount (verify) 
* $ stratis pool list; sstratisnstall stratisd
* $ dnf install stratis-cli
* $ blockdev list mypool (verify)
* $ lsblk (will show many block devices created by stratis)
* $ blkid; vim /etc/fstab

```
UUID="longblkidnumber"	/myfs1	xfs defaults,x-systemd.requires=stratisd.servcice 0 0
```

* $!blkid >> /etc/fstab (this command will get long UUID in vim, DON'T FORGET DOUBLE >>   grep /dev/mapper can also be added to get the stratis UUID quicker)
*the /dev/stratis/mypool/myfs can be used instead of UUID
* $ reboot (recommended, on stratis, on stratis!)


#### revert snapshot to previous one taken
* $ umount /myfs1
* $ stratis fs destroy mypool myfs1
* $ stratis fs snapshot mypool myfs1-snap myfs1 (won't work on LVM)


### Useful Directories/Files
* /dev/stratis/POOLNAME

### Useufl Packages
* dnf install stratisd
* dnf install stratis-cli

---

## Notes
1. **wipefs --all** is necessary before pool creation


---
[^Stratis]: taken from [RHEL](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/managing_storage_devices/setting-up-stratis-file-systems)
