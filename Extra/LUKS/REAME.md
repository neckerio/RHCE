# LUKS

## Objective Extra
* Review LUKS

---

### Implementation
* [luks.yml](luks.yml)
* [delluks.yml](delluks.yml)

### Useful Information
* LUKS Encrypted Device - 
	* to automate cryptsetup luksOpen use /etc/crypttab
	* to automate mounting the volume use /etc/fstab
	* /dev/sdx > cryptsetup luksformat > cryptsetup luksOpen NAME > /dev/mapper/NAME > mkfs.xx > mount
	* Cryptsetup is a utility used to conveniently set up disk encryption based on the DMCrypt kernel module.



* Linux Unified Key Setup-on-disk-format [^LUKS]
	* enables you to encrypt block devices and it provides a set of tools that simplifies managing the encrypted devices. LUKS allows multiple user keys to decrypt a master key, which is used for the bulk encryption of the partition. 
	*  LUKS encrypts entire block devices and is therefore well-suited for protecting contents of mobile devices such as removable storage media or laptop disk drives. 
	*  The underlying contents of the encrypted block device are arbitrary, which makes it useful for encrypting swap devices. This can also be useful with certain databases that use specially formatted block devices for data storage. 
	*  LUKS uses the existing device mapper kernel subsystem. 
	*  LUKS provides passphrase strengthening, which protects against dictionary attacks. 
	*  LUKS devices contain multiple key slots, allowing users to add backup keys or passphrases. 


* In RHEL, the default format for LUKS encryption is LUKS2
* The LUKS2 format supports re-encrypting encrypted devices while the devices are in use.
* When encrypting a non-encrypted device, you must still unmount the file system.


* LUKS2 provides several options that prioritize performance or data protection during the re-encryption process: 
	* **checksum:**  This is the default mode. It balances data protection and performance. 
	* **journal:** That is the safest mode but also the slowest. This mode journals the re-encryption area in the binary area, so LUKS2 writes the data twice. 
	* **none:** This mode prioritizes performance and provides no data protection. It protects the data only against safe process termination, such as the SIGTERM signal
	*  You can select the mode using the --resilience option of cryptsetup. 



#### Encrypting existing data on a block device using LUKS2
* Prerequisite:
	* backup data
	* block device contains a filesystem

* $ umount /dev/X
* $ lvextend -L+32M vg00/lv00 (free space for the LUKS header **parted** and **resize2fs** can also be usede)
* $ cryptsetup reencrypt --encrypt --init-only --reduce-device-size 32M /dev/X LUKSNAME
* $ mount /dev/mapper/LUKSNAME /mnt/encrypted
* $ cryptsetup reencrypt --resume-only /dev/X



#### Encrypting a blank block device using LUKS2
* Prerequisite:
	* blank block device
* $ cryptsetup luksFormat /dev/sda1
* $ cryptsetup open /dev/sda1 LUKSNAME
	* This unlocks the partition and maps it to a new device using the device mapper. This alerts kernel that device is an encrypted device and should be addressed through LUKS using the /dev/mapper/device_mapped_name so as not to overwrite the encrypted data. 
* $ mkfs.ext4 /dev/mapper/LUKSNAME
* $ mount /dev/mapper/LUKSNAME /mnt/encrypted

* mount AUTO
	* $ vim /etc/fstab
	* 	/dev/mapper/secret	/secret		xfs 	defaults	0 0 
	* $ vim /etc/crypttab (name of device, location of LUKS, none=no automate entering password)
	* secret		/dev/(Partition where LUKS is located)		none




#### Creating a LUKS encrypted volume using the Storage System Role
* Prerequisites:
	* The **ansible-core** and **rhel-system-roles** packages are installed. 
* $ vim luks_role.yml
	* - hosts: all
	  vars:
	    storage_volumes:
	      - name: barefs
		type: disk
		disks:
		 - sdb
		fs_type: xfs
		fs_label: label-name
		mount_point: /mnt/data
		encryption: true
		encryption_password: your-password
	  roles:
	   - rhel-system-roles.storage





### Useful Modules
* community.crypto.luks_device
	* device:
	* keyfile: PATH
	* label:
	* name:
	* passphrase:
	* remove_keyfile:
	* remove_passphrase:
	* state: (present/absent/opened/closed)
	* type: (luks1/luks2)
	* uuid:

### Useful Commands
* lsblk
* blkid
* cryptsetup
* wipefs
* udevadm settle (wait for system to register new dev name)
* cryptsetup luksFormat (format LUKS device)
* cryptsetup luksOpen NAME (open and create device mapper name)


#### create LUKS device
* $ fdisk /dev/sdx; n>p>ENTER>2G>w
* $ lsblk
* $ cryptsetup luksFormat /dev/sdx; > passphrase INTERACTIVE
* $ cryptsetup luksOpen /dev/sdx secret; >enter passphrase
* $ ls -l /dev/mapper (device named secret should be created)
* $ mkfs.xfs /dev/mapper/secret 
* $ mkdir /secret
* $ vim /etc/fstab
* /dev/mapper/secret	/secret		xfs	defaults	0 0 
* /dev/mapper/secret	/secret		xfs	noauto		0 0 
	* the "noauto" option doesn't mount partition automatically, but it still asks for password at book
* $vim /etc/crypttab
	* secret /dev/sdx none 
* $ reboot (it will ask for passphrase after reboot) 


### Useful Directories/Files
* /ect/crypttab
* man crypttab

### Useful Packages

---

## Notes

---
[^LUKS]: taken from [RedHat](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/security_hardening/encrypting-block-devices-using-luks_security-hardening)
