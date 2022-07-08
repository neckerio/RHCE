# VDO

## Objective Extra
	* Practice using VDO

---

### Implementation

### Useful Information
* VDO - Virtual Data Optimizer [^VDO]
	* A kernel module that can save disk space and reduce replication bandwidth
		-  provides thin provisioned storage
		- use logical size 10x the phys size for VMs and containers
		- use logical size 3x this phys size for object storage 
		- used in cloud and container environments
		- it manages deduplicated and compressed storage pools in RHEL8
		- underlying block devices need to be bigger than 4GiB
		- mkfs.xfs -K needed! stands for discard, without it will take forever
		- /etc/fstab needs
			- x-systemd.requires=vdo.service discard (mount option)
		- can be created on top of partition

	* VDO sits on top of any block storage device and provides zero-block elimination, deduplication of redundant blocks, and data compression. These are the key phases of the data reduction process that allows VDO to reduce data footprint on storage. [^VDO]
	*  Virtual Data Optimizer (VDO) provides inline data reduction for Linux in the form of deduplication, compression, and thin provisioning. When you set up a VDO volume, you specify a block device on which to construct your VDO volume and the amount of logical storage you plan to present. [^VDO2]
		1. **Zero-Block Elimination** - VDO only allows blocks that contain something other than all zeros to filter through to the next phase of processing.
		2. **Deduplication** - In this second phase, the incoming data is processed to determined whether it is redundant data (data that has been written before) or not. The redundancy of this data is checked through metadata maintained by the UDS (Universal Deduplication Service) kernel module delivered as part of VDO. Any block of data that is found to be redundant will not be written out. Instead, metadata will be updated to point to the original copy of the block already stored on media.  
		3. **Compression** - Once the initial zero elimination and deduplication phases are completed, LZ4 compression is applied to the individual data blocks. The compressed data blocks are then packed together into fixed length (4 KB) blocks and stored on media.  Because a single physical block can contain many compressed blocks, this can also speed up the performance for reading data off storage.
	* When VDO creates a volume on a block storage device, it divides the device into 2 portions internally: 
		1. UDS Portion: The size of this portion is fixed unless additional capacity is explicitly specified when the VDO volume is created. It is used store the unique name and location of each block seen as deduplication advice is requested of the UDS driver by the VDO device.
		2. VDO Portion: The VDO portion is the space that VDO uses to add, delete and modify user data and its associated metadata.
	* VDO supports 3 write modes:
		1. The ‘sync’ mode, where writes to the VDO device are acknowledged when the underlying storage has written the data permanently
		2. The ‘async’ mode, where writes are acknowledged before being written to persistent storage. In this mode, VDO is also obeying flush requests from the layers above. So even in async mode it can safely deal with your data - equivalent to other devices with volatile write back caches. This is the right mode, if your storage itself is reporting writes as ‘done’ when they are not guaranteed to be written.
		3. The ‘auto’ mode, now the default, which selects async or sync write policy based on the capabilities of the underlying storage.

	* The VDO solution consists of the following components: 
		1. KVDO -  A kernel module that loads into the Linux Device Mapper layer provides a deduplicated, compressed, and thinly provisioned block storage volume. 
		2. UDS - A kernel module that communicates with the Universal Deduplication Service (UDS) index on the volume and analyzes data for duplicates.
	*  A VDO volume is a thinly provisioned block device. To prevent running out of physical space, place the volume above a storage layer that you can expand at a later time. Examples of such expandable storage are LVM volumes or MD RAID arrays. 
	*  You can place thick-provisioned layers above VDO, but you cannot rely on the guarantees of thick provisioning in that case. Because the VDO layer is thin-provisioned, the effects of thin provisioning apply to all layers above it. If you do not monitor the VDO device, you might run out of physical space on thick-provisioned volumes above VDO. 
	 
	* Configuration:
		1. Layers that are placed under VDO
			- DM Multipath
			- DM Crypt
			- Software RAID (LVM or MD RAID)
		2. Layers that are placed above VDO
			- LVM Cache
			- LVM Snapshots
			- LVM Thin Provisioning
		3. UNSUPPORTED CONFIGURATIONS:
			- VDO above other VDO volumes
			- VDO above LVM snapshots
			- VDO above LVM cache
			- VDO above a loopback device
			- VDO above LVM thin provisioning
			- Encrypted volumes above VDO
			- Partitions on a VDO volume
			- RAID, such as LVM RAID, MD RAID, or any other type, above a VDO volume 

### Useful Modules
* vdo:
	* activated: BOOL
	* compression: ENABLED/DISABLED
	* deduplication: ENABLED/DISABLED
	* device: PATH
	* force: BOOL
	* growphysical: BOOL
	* indexmode: spapse/dense
	* logicalsize: 
	* name:
	* running: BOOL
	* state: present/absent
	* writepolicy: AUTO/sync/async

### Useful Commands
* VDO:
	* ansible-galaxy collection install community.general
	* vdo create --name=vdo1 --device=/dev/sdx --vdoLogicalSize=1T 
	* mkfs.xfs -K /dev/mapper/vdo1 
		- -K useful for VDO, it speeds up the formatting of XFS filesystems by not sending discard requests at filesystem creation time. It will already be initialized to zero at creation time
	* mkfs.ext4 -E nodiscard /dev/mapper/vdo-name (EXT4 filesystem)
	* mount -o discard /dev/mapper/vdo /mnt
		- The "discard" option while mounting the "/dev/mapper/vdo_vol" is used by the filesystem to inform VDO when blocks have been deleted. This can be done either by using  the discard option in the mount command or by periodically running the fstrim utility.  Discard behavior is required to free up previously allocated space on thin provisioned devices.
	* udevadm settle (wait for system to register new dev name)
	* vdostats --human-readable (monitor) 


### Useful Directories/Files
* man vdo (examples)
* /usr/share/doc/vdo/examples/systemd
* /etc/fstab

### Useful Packages
* ansible-galaxy collection install community.general
* vdo (may need a reboot)
* kmod-kvdo (may need a reboot)

---

## Notes
* Mount in /etc/fstab
1. For XFS


```
/dev/mapper/vdo-name mount-point xfs defaults,x-systemd.device-timeout=0,x-systemd.requires=vdo.service 0 0
```


2. For EXT4



```
/dev/mapper/vdo-name mount-point ext4 defaults,x-systemd.device-timeout=0,x-systemd.requires=vdo.service 0 0
```



3. If the VDO volume is located on a block device that requires network, such as iSCSI, add the _netdev mount option. 


---
[^VDO]: taken from [redhat](https://www.redhat.com/en/blog/understanding-concepts-behind-virtual-data-optimizer-vdo-rhel-75-beta)
[^VDO]: taken from [redhat](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/deduplicating_and_compressing_storage/deploying-vdo_deduplicating-and-compressing-storage)
