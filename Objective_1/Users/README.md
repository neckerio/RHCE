# Manage Users and Groups

## Objective RHCE
* Be able to perform all tasks expected of a Red Hat Certified System Administrator
	*  Manage users and groups

## Objectice RHCSA
* Manage users and groups
	* Create, delete, and modify local user accounts
        * Change passwords and adjust password aging for local user accounts
        * Create, delete, and modify local groups and group memberships
        * Configure superuser access

---

### Useful Information
* when you "userdel" someone a UID stays (1002) if you then create a new user, that new user takes over that UID and therefore the old files
* useradd --base-dir (-b) must exist if -m isn't used. /home by default
* USERGROUPS_ENAB	yes - in /etc/logins.def this means userdel will delete the group with the same name as the user. If it is used as a primary group for another user this will just give a warning.


### Useful Commands
* useradd
* useradd -D (display defaults)
* useradd -G group1,group2,group3 user (multiple groups)
* useradd -m (create homdir if not done automatically)
* userdel -f (force deletion of homedir/mail no matter what)
* userdel -r (remove homdir/mail, check to make sure others aren't usingit)
* usermod -aG wheel user (add user to secondary group later)
* groupadd groupname (add new group)
* groupdel (delete group)
* groupmod (^this andthe above will try to remove the groupid as well)
* chage (password age, interactive)
* su - user (login shell)
* passwd
* id user
* groupmems -l -g groupname (show all users who are a member of a specific group, shows primary group assignments unlike cat /etc/group)(RHEL)
* groupmems -g groupname -l (Artix)
* lig -g groupname (RHEL, shows even users using groupname as primary)
* usermod -aG groupname username (to assign new users to group)
* passwd -l USER = lock account
* passwd -d USER = delete password
* passwd -e USER = expire password
* passwd -n #DAYS USER = minimum password lifetime in days
* passwd -x #DAYS USER = max password lifetime in days
* passwd -S USER = give status of password for user


### Useful Directories/Files
* /etc/login.defs (to modify password age etc)
* /etc/skel
* /etc/defaults/useradd (mod passwd age home directory etc)
* /etc/subgid (subordinate gid)
* /etc/subuid (subordinate uid)
* /etc/group
	* groupname:x(password):UniqueGID:namesofMembers
* /etc/gshadow (group shadow)
* /etc/shadow
	* user:hashpass:17912(Linuxepoch)creation:minValid:Maxvalid* ysbeforeExpire:
		* if password is :!!: it is disabled (default)
* /etc/passwd
	* user:password:UID:GID:GECOS (additional non mandatory):home dir:shell

### Useful Packages

---

## Notes
