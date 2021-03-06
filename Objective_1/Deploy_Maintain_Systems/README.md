#  Deploy, configure, and maintain systems

## Objective RHCE
* Be able to perform all tasks expected of a Red Hat Certified System Administrator
	* Deploy, configure, and maintain systems

## Objective RHCSA
* Deploy, configure, and maintain systems
	* Schedule tasks using at and cron
        * Start and stop services and configure services to start automatically at boot
        * Configure systems to boot into a specific target automatically
        * Configure time service clients
        * Install and update software packages from Red Hat Network, a remote repository, or from the local file system
        * Work with package module streams
        * Modify the system bootloader

---

### Useful Information
#### cron
* cron for mutliple times "at" command for once
* don't modify /etc/crontab!!!
* use snapin filesin /etc/cron.d
	* or use a script in /etc/crontab.hourly|daily|weekly|monthly
	* or use crontab -e (for a specific user)
* anacron is behind the /etc/cronjob.xxx, it makes sure the cron job is started everyday on a time that is not specified


#### systemd
* Slice= Unit type for creating the cgroup hierarchy for resource management
	* user.slice (user part)
	* system.slice (system services)
	* machine.slice (virtual machines/containers etc)
	* Scope= Organizational unit that groups a services' worker processs
	* Service= Process/group of processes controlled by systemd

#### hwclock
* hardware clock (system takes it from here at boot)
* software clock (set accoring to HW clock)
* network time
* chronyd is the new NTP service (takes care of ntp time sync)
* NTP = network time protocol, most linux systems are connceted to it, could be on the net or server etc. can sync from here. ONLY works if it IS NOT off by more than 1000 SECONDS!
 

#### repo
* the repositories created in /etc/yum.repos.d/* need to have .repo sufix
* dnf groups gives access to specific categories of software
* subscription-manager doesn't work with CentOs


#### bootloader
* grub.cfg is automatically generated by grub2-mkconfig using templates from /etc/grub.d and settings from /etc/default/grub	
* kernels are installed through the boot directory, grub automatically searches this directory for any versions of the kernel
* overview of boot process
	* Post >BIOS/UEFI> Grub bootloader> kernel & Initramfs> systemd> Base-os> services
* Post (power on self test which is hardware)
* initramfs (Initial Ram FileSystem) containts temporary root directory and all drivers needed to start the Linux operating system
* Base-os (has devices and mounts etc are loaded) Phase 1
* Services (Phase 2)
* the rescue kernel is the kernel that boots with restrictive options




### Useful Commands
#### cron
* crontab -l (if it exits for user)
* crontab -e (edit, or make new)
	* * * * * * command
	* @hourly command
	* @daily command
	* reboot command (on every reboot)
* crontab -e */10 * * * * (every 10 minutes)
* sudo crontab -u sveta -e 
* sudo crontab -u sveta -l
* systemctl enable --now atd (at daemon)
* at TIME
	* interactive
	* CTRL+D = save and exit
* atq (for list of currently scheduled jobs)at TIME
* atq (for list of currently scheduled jobs)
* atrm (to remove jobs from list)
* cp /usr/lib/tmpfiles.d/tmp.conf /etc/tmpfiles.d/ (copy config)
	* vim /etc/tmpfiles.d/tmp.conf



#### systemd
* bootctl (control the firmware and boot manager settings)
* systemd-notify (daemon to notify about status completion/changes)
* systemctl status pid
* systemctl is-enabled service ( to get an answer to stdout)
* systemctl daemon-reload
* systemctl edit unit
* systemctl revert unit (revert edits)
* systemctl is-enabled service (scripts, return 0 if true)
* systemctl mask service (prevent manual/other serivce start)
* systemctl unmask service
* systemctl list-units --type target --type target
* systemctl help service (open man page for target)
* systemctl cat service (cat file from /usr/lib/systemd/system/service)
* systemd-cgls (recursively show cgroup content)
	* systemctl get-default
	* systemctl set-default
* systemctl set-default multi-user.target (chnage default target)
* change default using symbolic links only (systemctl preferred)
	* rm /etc/systemd/system/default.target
	* ls /lib/systemd/system/default.target
	* ln -sf /lib/systemd/system/graphical.target /etc/systemd/system/default.target;reboot
* change to a different target unit during current session
	* systemctl isolate multi-user.target
	* systemctl rescue (will send a message to other users)
	* systemcl isolate rescue.target
	* systemctl --no-wall emergency (turn off messages)
	* systemctl isolate emergency.target

* [Unit] section
	* generic options, description, behavior, set dependencies to other units
        	* Description
          	* Documentation=url list
         	* After=unit starts only after specified units are up
         	* Requires=like after but starts other units itself
         	* Wants=like requires but will start if others fail
         	* Conflicts=opposite of requires; negative dependencies
* [Service] section options
		* Type=config unit process startup type used by execstart
		* Restart=service is restarted after process exits
		* RemainAfterExit=considered active after proc exit
* [Install] section options
		* Alias=space seperated list
		* RequiredBy=list of unites required by the unit
		* WantedBy=list of units that weakly depend on the unit
		* Also=list of units to be un/installed with the unit
		* DefaultInstance=limited to instantiated units, specifies the default instance for which the unit is enabled



 
#### hwclock
* hwclock (set time at hardware level, sync between hardware and software)
* hwclock -systohc
* hwclock -hctosys
* date (old, set current time and display format)
* timedatectl (manage all aspects of time)
* timedatectl (generic interface, set things like timezone)
* tzselect (select the current timezone)
* timedatectl --help
* timedatectl status
* timedatectl list-timezones
* timedatectl set-timze America/Los_Angeles
* timedatectl show (verify)
* chronyc (RHEL)


#### repo
* createrepo (not necessary, but may be useful. Turn rpms into repo)
* netstat -tulpen | less (show listening ports etc)
* dnf list package
* dnf info package
* dnf repolist
* dnf provides command/file/etc
* dnf module list (list of available modules)
* dnf module provides package (specific package)
* dnf module info package
* dnf module info --profile package (shows profiles)
* dnf module list package (list of stream for package)
* dnf module install php:7.1
	* dnf module install php:7.2 (HOW TO UPDATE MODULE)
	* dnf install @php:7.1
* dnf module install php:7.1/devel (install specific profile)
* dnf module enable php:7.1 (enables module but doesn't install)
* dnf groups list (list groups)
* dnf groups list hidden (shows all)
* dnf groups info groupname 
* dnf groups install groupname 
* dnf history
* dnf history undo
* dnf update (package)
* rpm -qf file (package name from which originates file)
* rpm -ql package (list what came inside package)
* rpm -qc package (show config files coming from package)
* rpm -qd package (shows documentation only from package)
* rpm -qp --scripts mypackage-file.rpm (checks for scripts in rpm packages before install)
* yumdownloader package (downloads rpm package as package.rpm)
* subscription-manager register
	* username of Red Hat account
	* password to account
	* subscription-manager attach --auto (connect current subcription to redhat repos)
	* dnf repolist (verify)
* dnf --showduplicates list PACKAGE
* dnf downgrade PACKAGE
* dnf downgrade 
* dnf list intalled | grep PACKAGE = get installed version and info


* WALKTHROUGH in NOTES



#### bootloader
* grub2-mkconfig (to compile changes made to /etc/default/grub to /boot/grub2/grub.cfg)
* grub2-mkconfig -o /boot/grub2/grub.cfg (BIOS)
* grub2-mkconfig -o /boot/efi/EFI/redhat/grub.cfg (EFI)
* mount | grep '^/' (look for anything mounted to efi to determine if you use efi)
	* mount | grep '^/' | grep -i efi




### Useful Directories/Files
#### cron
* /etc/cron.xxx
* /etc/anacrontab
* man 5 crontab (for time reference)
* man 5 systemd.timer
* man systemd.time
* /var/log/messages (for logger)
* /usr/lib/systemd/system/*timer
	* example of systemd.timer/service THE NAMES MUST MATCH
* /usr/lib/systemd/system/fstrim.service
	* /usr/lub/systemd/system/fstrim.timer (both go together)
* man at
* man tmpfiles.d (just in case they ask?)
* man systemd-tmpfiles


#### systemd
* man 5 systemd.unit
* man 5 systemd.service
* man 7 systemd.journal-fields
* /etc/systemd/system/xxx.target.wants/SERVICE
* /usr/lib/systemd/system/SERVICE


#### repo
* /etc/yum.repos.d
* man yum.conf
* man fstab (/iso, to help remember the third field filesystem iso)


#### bootloader
* /boot/grub2/
* /boot/grub2/grub.cfg (config file, says DO NOT EDIT)
* /etc/default/grub 


### Useful Packages
#### cron
* cronie (for cron and crontab)
* at (for at and the daemon atd)

#### systemd stuff
* systemd-container

#### repo
* dnf-utils (yum-downloader)



---

## Notes
1. set iso from disk 
	* dd if=/dev/sr0 of=/rhel8.iso bs=10M status=progress
	* mkdir /myrepo
	* vim /etc/fstab
		* /rhel8.iso	 /myrepo	iso9660 	defaults	0 0 
	* systemctl daemon-reload; mount -a
	* cd /repo; ls (verify)

	* mkdir /etc/yum.repos.d/appstream.repo
		* [appsteam]
		* name=appstream
		* baseurl=file:///myrepo/Appstream
		* gpgcheck=0

	* mkdir /etc/yum.repos.d/base.repo
		* [baseos]
		* name=baseos
		* baseurl=file:///myrepo/BaseOs
		* gpgcheck=0

	* sudo dnf repolist (verify acccess)
