# Advanced Storage

## Objective Extra
	* Practice using VDO and Stratis

---

### Implementation

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
* stratis fs snapshot mypool myfs1 myfs1-snapshot*  mount /stratis/mypool/my-fs-snapshot /mnt (to mount)
* stratis filesystem destroy mypool mysnapshot (delete snap)
* stratis filesystem destroy mypool myfs (destroy filesystem)
* stratis pool destroy mypool (destroy pool when no more fs exist)
* vdo create --name=vdo1 --device=/dev/sdx --vdoLogicalSize2=1T 
* mkfs.xfs -K /dev/mapper/vdo1 (-K needed for VDO)
* udevadm settle (wait for system to register new dev name)
* vdostats --human-readable (monitor) 
      

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

---

## Notes
