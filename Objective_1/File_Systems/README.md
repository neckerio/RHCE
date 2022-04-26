#  Create and configure file systems

## Objective RHCE
* Be able to perform all tasks expected of a Red Hat Certified System Administrator
	*  Create and configure file systems

## Objective RHCSA
* Create and configure file systems
	* Create, mount, unmount, and use vfat, ext4, and xfs file systems
        * Mount and unmount network file systems using NFS
        * [Extend existing logical volumes](Objective_1/Storage)
        * Create and configure set-GID directories for collaboration
        * [Configure disk compression](Objective_1/Storage)
        * [Manage layered storage](Objective_1/Storage)
        * Diagnose and correct file permission problems

---

### Useful Information
#### gid
* gid sets group to group owner of dir
* sticky means they can't delete files unless they are owner of group or directory

#### filesystems
* if at anytime during boot you get "give root password for maintenance", there is a problem with /etc/fstab
* swap is mounted just at "swap" becaues it is directly to the kernel and doesn't need a directory exactly
* in fstab the 6th section is for "fsck"; 1 is the root (if they don't ask to check filesystem automatically don't do it)
* fdisk for MBR and gdisk for GPT!!!!!!

#### permissions
* create regular permissions first because default acl's are informed by standard control lists
* permissions operate as EXIT on MATCH, it goes down the permissions list and applies what first matches ------r-x, would mean the owner wouldn't be able to read this file
* sticky bit is lowercase "t" when there is an x (execute) bit also
* sticky bit is uppercase "T" if it is just sticky with no x
* FILE rwx = read, modify, run (usually x not given for security)
* DIR rwx = list, delete/create, cd (enter)(r always with x)
	* FILE/DIR permissions probably given differently, therefore
		* FILE = -rw-r--r--
		* DIR  = drwxr-xr-x
	* FILE special
		* SUID = run as owner (only applies to executable files)
		* SGID = run as group owner ( 
		* Sticky = nothing
	* DIR special
		* NO meaning
		* SGID = all files created will inherit dir group owner
		*  Sticky = delete only if you are owner of the file or directory containing the files
	* Sticky,SUID,SGUID all accumulate in permissions
		* 3775 (Sticky and SGUID)
		* SUID   = 4
		* SGUID  = 2
		* Sticky = 1
* getfactl and setfacl = effective id applies to files. dir will just inherit the defaults. 
* Normal ACL applies to existing files ONLY
* Default ACL aplies to new files
* setfacl -R (DON'T FORGET RECURSIVE IF DIR in DIR's EXIST!)
	* if default is set on a directory it becomes recursive automatically
* umask file default = 666 (subtract)
* umask dir default = 777 (subtract)


#### nfs
* used for creating a samba, shared-like server/blk
* firewall-cmd will need nfs, rpc-bind and mountd for nfs to work
* base NFS server setup NOT ON RHCSA
* connecting to NFS server IS ON RHCSA
* the exports file tells the NFS server what to share
* no_root_squash = if client connects as root they stay root on server, technically insecure but allows complete access
* if no_root_squash ISN'T added then the user connects as NOBODY, which is a limited user
* Samba server set up ISN't on RHCSA
* Samba connection IS ON RHCSA
* the reason Samba users get password is because it will be used by windows users and don't want windows servers logging into your console server
* Samba persistent mount requires _netdev,username=,password= options in /etc/fstab
	* if not you will be asked during boot for password etc
	* you can also specify noauto option to not automatically mount
* cifs is the standarized name for Samba
* autofs (automount) mounts the directory when you use it and unmounts it when it isn't used for a time
* in automount you always have to components in the directory name of the mount (/data/files=fullname, do /data in /etc/auto.master) (files=relative file name, in /etc/auto.data)
* ensure autofs service is started (systemctl)
 

		

### Useful Commands
#### gid
* chgrp sales sales (one directory/one group)
* chmod g+s sales (sets gid on directory sales)
* chmod +t . (add sticky bit on current directory)

#### filesystems
* df -h
* free -m
* blkid
* partprobe (to update fdisk, or storage changes)
* xxd (make a hex dump)
* man fsck
* mkfs.ext4 (block size default is 4k)
* partprobe (to update fdisk, or storage changes)
* xxd (make a hex dump)
* mke2fs (make an ext1,2,3,4 file system, more control?)
* e2fsck (check an ext file system, more control?)
* dumpe2fs (dump ext file system, more control?)
* e2mmpstatus (multiple mount protection ext fs, protect simultaneous use)
* tune2fs (adjust tunable ext file systems, more control?)


#### permissions
* ls -l
* chmod o+x file1
* chmod o+w file1
* groupadd piter
* usermod -aG piter masha
* chmod o-w file1
* chmod o-rx dir1
* chown sveta:piter dir1
* chmod g+rx dir1
* chmod 644 file1
* chmod g-rx,u+w file1
* chmod 4755 dir (SUID)= drwsr-xr-x
	* chmod u+s dir (SUID) = drwsr-xr-x
* chmod 2755 dir (SGID)= drwxr-sr-x
	* chmod g+s dir (SGID) = drwxr-sr-x
* chmod 1755 dir (Sticky) = drwxr-xr-t
	* chmod +t dir (Sticky) = drwxr-xr-t 
* getfacl file/dir
* setfacl file/dir = drwxrwx---+
* setfacl -m g:account:rx sales; setfacl -m d:g:account:rx sales
* setfacl -m g:sales:rx account; setfacl -m d:g:sales:rx account
* setfactl -R -m  g:sales:rx account (if there are files in the directory)
 
* umask
* umask 222 = dr-xr-xr-x (555) (not persistent)

* find / -perm /6000 = find all files with SUID+SGUID activated



#### nfs
* showmount (show mount info for nfs server)
	* IMPORTANT: this may return an rpc error about not finding a route to the nfs server. Try checking ports, opening firewall and if none of that works MOUNT IT ANYWAY. it may work even though the "showmount" command does not
* rpcinfo -p (no ipaddress will search localhost)
* rpcinfo -p ip.add.re.ss 
* telnet -tulpn | grep nfs (find ports that need to be opened for firewall, 2049 is usually the one, maybe 111 as well)
* showmount -e nfs-server (show exports)
* mount nfsserver:/share /mnt
* nfsstat (show nfs stats)
* rpc.nfsd (start nfs daemon)
* rpc.nfsd 0 (stop all threads, close any connections)
* smbpasswd -a (add samba user account, must match existing linux user)
* systemctl start smb
* smbclient -L //sambahost (discover shares)
* mount -o username=sambauser //sambawhatever/share /somewhere (moun share)
* systemctl enable --now autofs (automount)

* WALKTHTOUGHS in Notes section




### Useful Directories/Files
* /etc/fstab
* /etc/profile (umask 002)
* /etc/bashrc (umask 00d)


#### nfs
* /usr/sbin/rpc.nfsd
* /etc/exports (nfs export tables)
* man nfs (will show you how to mount)
* man nfsd
* man nfs.conf
* man exports (for options)
* /etc/fstab (make nfs mount persistent)
* /etc/samba/smb.conf
* /etc/auto.master
* /etc/auto.mount (identify dir that automount should manage and the file that is used for additional mount information)
	* /data /etc/auto.data (example)
		* /data (name of dir to manage)
		* /etc/auto.data (file that contains specs for that dir)
* /etc/auto.data (identify the subdirectory on which to mount, and what ot mount exactly)
	* files -rw nfsserver:/data/files
		* files= subdir of /data
* /net (automatically created,when you start autofs service. Managed by automount
* /misc (autocreated like /net by autofs)
* /etc/auto.misc
	* linux (and others examples of subdirectories of misc)
	* -ro,soft,intr (options)
	* ftp.example.org:/pub/linux (what to mount)
	* :/dev/hdax (the colon tells autofs it is a device)


### Useful Packages
* dnf install nfs-utils
* dnf install samba
* dnf install cifs-utils (for samba)
* dnf install autofs (automount)


---

## Notes
1. quick way to get UUID from vim /etc/fstab
	* vim /etc/fstab
	* :r !blkid (then choose the correct one and delete the others

2. mount an nfs server persistently on /localnfs.
	* showmount -e ip.add.re.ss; vim /etc/fstab
	* ip.add.re.ss:/nameOfNFSshare	/localnfs	nfs	_netdev		0 0

3. Configure NFS server on /data (*=everybody)
	* systemctl status nfs-server
	* mkdir /data
	* vim /etc/exports
	* ata *(rw,no_root_squash)
	* systemctl enable --now nfs-server; systemctl status nfs-server
	* firewall-cmd --add-service nfs
	* firewall-cmd --add-service nfs --permanent
	* firwwall-cmd --add-service mountd
	* firwwall-cmd --add-service mountd --permanent
	* firwwall-cmd --add-service rpc-bind
	* firwwall-cmd --add-service rpc-bind --permanent
	* firewall-cmd --list-all (verify)

4. Connect to NFS server (ON RHCSA!!!)
	* showmount -e ip.add.re.ss (should display exports available)
	* mount ip.add.re.ss:/data /mnt
	* umount /mnt (to make persistent)
	* mkdir /nfs
	* vim /etc/fstab
	* .add.re.ss:/data	/nfs	nfs	_netdev		0 0 
	* mount -a; mount (verify)
	* reboot (definitely test this because networking is required)

5. Configure Samba server
* mkdir /samba
* useradd samba
* chown samba /samba
* chmod 770 /samba
* smbpasswd -a samba (new samba password, interactive)
* vim /etc/samba/smb.conf
	* [samba]
		* comment = samba share
		* path = /samba
		* write list = samba (name of user who is allowed to write)
* systemctl enable --now smb; systemctl status smb (there may be 2 error messages, it is fine as long as it is running)
* firewall-cmd --add-service samba
* firewall-cmd --add-service samba --permanent
* firewall-cmd --reload
* firewall-cmd --list-all (verify)

6. Connect to Samba server (ON RHCSA)
* dnf groups list --hidden
* dnf groups install "Network File System Client"
* smbclient -L //ip.add.re.ss (server address)
	* >enter Samba/root password: (not configured so just hit enter to see shares)
* mount -o username=samba //ip.add.re.ss/samba /mnt
	* >password for samba user: (this was configured using sambapasswd)
* mount (verify) (mount type = cifs, which is the same as samba) 
* vim /etc/fstab
	* //ip.add.re.ss/samba	/samba	cifs	_netdev,username=samba,password=password 0 0 
* mkdir /samba
* mount -a (verify)
* reboot (recommended for _netdev and NFS/Samba to verify it works)
* mount -a (verify)

7. automount for some reason
* showmount -e ip.add.re.ss (as stated before this command may not work even though mounting nfs itself works fine)
* ls / (look at root before autofs)
* systemctl enable --now autofs
* ls / (additional dirs created, /net and /misc)
* vim /etc/auto.master
	* /misc 	/etc/auto.misc
* vim /etc/auto.misc (contents of config file, and examples)
* vim /etc/auto.master (create our own) 
	* /files	/etc/auto.files (good convention that they match)
* vim /etc/auto.files (specify name of directory to be created, absolute path = /file/data)
* ta 	-rw 	ip.add.re.ss:/data
* systemctl restart autofs
* ls / (see directory files has been created)
* cd files
* ls -a (nothing in there, because there is no need to mount yet until...)
* cd data (activates /files/data)
* pwd (returns /files/data)
* mount | grep data (see that it is an nfs4 mount automatically mounted by autofs)
 
8. autofs home dirs, for ldap uses apparently. to take their homedirs with them. Create NFS share for ldap user homedirs, put them on one central server, user automount to mount a share to ldapuser homedir wherver the user is logging in. Files are really created on NFS server

* su - ldapuser1 (no such file or directory)
* ssh ip.add.re.ss
* vim /etc/exports
	* /home/ldap	*(rw)
* systemctl restart nfs-server
* exit (ssh)
* showmount -e ip.add.re.ss (verify it is offered by server)
* vim /etc/auto.master
	* /home/ldap	/etc/auto.ldap
* vim /etc/auto.ldap
	*	-rw	ip.add.ress:/home/ldap/& (* &=anything that matches)
* systemctl restart autfs
* su - ldapuser1
* pwd (it mounted it automatically)

