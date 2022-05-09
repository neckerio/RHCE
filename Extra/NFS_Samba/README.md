# NFS/Samba

## Objective EXTRA
* setup Samba on Host Node
* use Samba on Remote Nodes

---

### Implementation
* [nfs_server.yml](nfs_server.yml)
* [delnfs_server.yml](delnfs_server.yml)
* [nfs_client.yml](nfs_client.yml)
* [delnfs_client.yml](delnfs_client.yml)
* ^ may need to review the idempotency of these.

* [samba_server](samba_server.yml)
* [delsamba_server](delsamba_server.yml)
* [samba_client](samba_client.yml)
* [delsamba_client](delsamba_client.yml)

### Useful Information
#### nfs
* used for creating a smb, shared-like server/blk
* firewall-cmd will need nfs, rpc-bind and mountd for nfs to work
* the exports file tells the NFS server what to share
* no_root_squash = if client connects as root they stay root on server, technically insecure but allows complete access
* if no_root_squash ISN'T added then the user connects as NOBODY, which is a limited user

#### samba
* the reason Samba users get password is because it will be used by windows users and don't want windows servers logging into your console server
* Samba persistent mount requires _netdev,username=,password= options
	* if not you will be asked during boot for password etc
	* you can also specify noauto option to not automatically mount
* cifs is the standarized name for Samba
* autofs (automount) mounts the directory when you use it and unmounts it when it isn't used for a time
*  in automount you always have to components in the directory name of the mount (/data/files=fullname, do /data in /etc/auto.master) (files=relative file name, in /etc/auto.data)
* ensure autofs service is started (systemctl)
* smbpasswd needs to be run as root to add user 


### Useful Modules
* assert:
	* that:
	* fail_msg:
	* success_msg:

### Useful Commands
* showmount (show mount info for nfs server)
	* IMPORTANT: this may return an rpc error about not finding a route to the nfs server. Try checking ports, opening firewall and if none of that works MOUNT IT ANYWAY. it may work even though the "showmount" command does not
* rpcinfo -p (no ipaddress will search localhost)
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

* mount an nfs server persistently on /localnfs.
	* $ showmount -e ip.add.re.ss; vim /etc/fstab
	* ip.add.re.ss:/nameOfNFSshare	/localnfs	nfs	_netdev		0 0



### Useful Directories/Files
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
	*  ftp.example.org:/pub/linux (what to mount)
	* :/dev/hdax (the colon tells autofs it is a device)

### Useful Packages
* nfs-utils
* samba
* cifs-utils (for samba)
* autofs (automount)
* dnf groups install "Network File system Client"

---

## Notes
1. Samba server will need to handle a few SELinux variables; an seboolean and an fcontext
2. It may be possible to condense both of those into a single command "semanage permissive -a smbd_t" [^manpage] and just allow all processes.

---
[^manpage]: Helpful manpage from [linux.die.net](https://linux.die.net/man/8/samba_selinux)

