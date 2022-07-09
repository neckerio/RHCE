# Stratis

## Objective Extra
* Review Stratis

---

### Implementation

### Useful Information
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
* stratis pool destroy mypool (destroy pool when no more fs exist)


#### create a stratis system
* $ systemctl enable --now stratisd; ssystemctl status stratisd
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

### Useufl Packages
* dnf install stratisd
* dnf install stratis-cli

---

## Notes


---

