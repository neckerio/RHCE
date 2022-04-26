#  Understand and use essential tools

## Objective RHCE
* Be able to perform all tasks expected of a Red Hat Certified System Administrator
	*  Understand and use essential tools

## Objective RHCSA
* Understand and use essential tools
	* Access a shell prompt and issue commands with correct syntax
        * Use input-output redirection (>, >>, |, 2>, etc.)
        * Use grep and regular expressions to analyze text
        * Access remote systems using SSH
        * Log in and switch users in multiuser targets
        * Archive, compress, unpack, and uncompress files using tar, star, gzip, and bzip2	(! ARCHIVE
        * Create and edit text files
        * Create, delete, copy, and move files and directories
        * Create hard and soft links
        * [List, set, and change standard ugo/rwx permissions](Objective_1/File_Systems)
        * Locate, read, and use system documentation including man, info, and files in /usr/share/doc


---

### Useful Information
#### archive
* tar does NOT compress data
* tar compression
* -z = gzip
* -j = bzip2
* -J = xz


#### links
* block > inode > name (can have multiple names for 1 inode) > sym link
* hard link = when there are multiple names to one inode
* symbolic link = attaches to hard link, knows nothing about the inode
* symbolic links can go across devices and on directories
* if the hard link,the sym link is connected to, is deleted then the sym link is invalid
* if I modify one hard link, both become bigger (identical)
* symbolic links needs absolute path




### Useful Commands
#### grep
* grep /var/log/messages "^Apr*"
* grep -v "^foo*" /var/log/messages (inverse, anything without)
* grep -e "^Apr  2" /var/log/messages
* grep "^Apr  2" /var/log/messages | grep "dnf"
* grep "(uid=0)$" /var/log/secure (ending)
* dmesg | grep "^\[ 2406" (escape char)
* grep -Ev [^#] = get anything not commented out


#### ssh
* ssh -X or ssh -Y to display gui from target on local server
* ssh localhost (can work, if needed for some reason)
* ssh-keygen -t ed25519 -C "rhel" (+ add passphrase)
>enter file to save key: /home/USER/.ssh/rhel_id_ed25519
* ssh-copy-id -i ~/.ssh/rhel_id_ed25519.pub USER@email.com
* vim /etc/ssh/sshd.conf (SERVER)
	* Port 2222
	* PermitRootLogin no (make sure other account exists)
	* PasswordAuthentication no (make sure ssh is setup and works)
* systemctl restart sshd
* vim .ssh/config (HOST)
	* Host rhel
	* Hostname ip.ad.re.ss 
	* Port 22
	* User USER

	* Host rhel2
	* Hostname ip.ad.re.ss
	* Port 22
	* User USER
* ssh -i .ssh/rhel_id_ed25519 rhel
* journalctl -fu ssh(d)

* ssh agent (avoid passphrase)
	* ps aux | grep ssh-agent
	* eval "$(ssh-agent)" (gives pid)
	* ssh-add ~/.ssh/rhel_id_ed25519 (store password in memory)


#### Multi-user
* Log in and switch users in multiuser.target

* systemctl list-units --type target (find out which target)
* useradd USER
* id USER
* passwd PASSWORD
* su USER
* su -l USER (login shell, will have thier configs)



#### archive
* tar -cvf myarchive.tar /etc /hosts; file myarchive.tar (verify)
* tar tvf (view archive)
* tar -xvf myarchive.tar -C /tmp (extract elsewhere)
* gzip myarchive.tar (automatically creates extension)
* gzip -k myarchive.tar (keep original file as well)
* bzip2 myarchive.tar (doesn't seem to be able to name your own file)
* bzip2 -k myarchive.tar (keep old file)
* xz myarchive.tar (also doesn't accept name)
* xz -k myarchive.tar (keep old file)
* file myarchive.tar.xx (verify)

* COMPRESSION
* won't work on directories
	* gzip /var/log/messages
* messages.log.gz
	* ls -lh (to view size difference)
	* file messages.log.gz (verify)
	* gzip -d messages.log.gz (unzip)
		* gunzip messages.log.gz (unzip)
	* bzip2 messages.log (better compression)
	* bzip2 -d messages.log.bz2
		* bunzip messages.log.bz2
* ARCHIVE
* mkdir logs
	* tar -cvf logs.tar logs/ (archive)
	* tar -tvf logs.tar (show contents of an archive)
	* tar -xvf logs.tar (unarchive, tar doesn't go away automatically) 
	* gzip logs.tar 
* logs.tar.gz
	* tar -czvf logs.tar.gz logs/ (does both at the same time)
		* tar -czvf logs.tgz logs/ (both use gzip)
	* tar -xzvf logs.tar.gz(logs.tgz) EXTRACT
	* tar -cjvf logs.tar.bz2 logs/ (using bzip2)
	* tar -xjvf logs.tar.bz2 (extract)
	* tar -ztf logs.tgz (will list whats inside tar without extract)


#### links
* ln -s file.txt linkfile.txt (file first then link second)
* ls -li (inodes)
* ln file.txt hardlinkfile.txt (same inode)
	* rm file.txt (still one inode left)
* ln /etc/hosts /home/USER/hardhosts; ls -li /etc/hosts /home/USER/hardhosts
	* they will have the same inode
* ln -s /etc/hosts /home/USER/symhosts
* rm /etc/hosts; ls -li (symhost has a problem)
* ln /home/USER/hardhosts /etc/hosts
* ls -li (symhost is okay again)



#### man
* man 
* man man
* man apropos
* man -k 
* man # passwd
* apropos = search man page names and descriptions
* mandb = create and update man page index caches
* info = read info documents
* info passwd
* /usr/share/doc (might have some config examples)
* locate = find files by name
* file = determine file type
* whatis = display one line manual page description
* which = show full path of shell commands
* whereis= locate bin, source, and man pages for a command
* rpm -qd
* rpm -qf
* rpm -ql package (find out what's inside a package)
* rpm -qc package (find all configuration files)

* generate man database
	* sudo mandb
	* man mandb



### Useful Directories/Files
#### ssh
* /etc/ssh = where the ssh fingerprings are stored
* /etc/ssh/sshd_config (client); don't forget to restart sshd
	* X11Forwarding
	* Port
	* PermitRootLogin
	* PasswordAuthentication
	* AllowUsers USER
* /etc/ssh/ssh_config (server)



### Useful Packages
#### archive
* bzip2



---

## Notes





