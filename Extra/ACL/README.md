# ACL and SUID SGID +Sticky

## Objective: EXTRA
* Apply ACL's like a lifeless drone
---
### Implementation
* [acl.yml](acl.yml)
* [delacl.yml](delacl.yml)
* [specialbits.yml](specialbits.yml)
* [delspecialbits.yml](delspecialbits.yml)

### Useful Modules
* acl:
	* path:
	* default: BOOL
	* entity:
	* etype:
	* permissions: (rwx)
	* recursive: BOOL
	* state: (a/p query)

### Useful Commands
* getfacl
* setfacl
* ls -la

### Useful Directories/Files

### Useful Packages

---

## Notes
1. Important to set both DEFAULT and without it. 
2. Normal ACL applies to existing files ONLY. Default ACL aplies to new files. 
	*  setfacl -R (DON'T FORGET RECURSIVE IF DIR in DIR's EXIST!)
3. It is possible to use "remote_user: USER", at the same lvl as register: in the task section, to try creating a file on the remote nodes. Requires SSH keys and I am lazy. This may not even be on the test
4. create regular permissions first because default acl's are informed by standard control lists
5. permissions operate as EXIT on MATCH, it goes down the permissions list and applies what first matches ------r-x, would mean the owner wouldn't be able to read this file
6. SPECIAL BITS:
	* SUID = 4775
	* SGID = 2775
	* Sticky= 1775
	* File:
		* SUID = run as owner (only applies to executable files)
		* SGID = run as group owner 
		* Sticky = nothing
	* Directory:
		* SUID = NO meaning
		* SGID = all files created will inherit dir group owner
		* Sticky = delete only if you are owner of the file or directory containing the files
7. To remove the SUID,SGUID and STICKY bit, OCTAL, add an extra 0 before the permission: chmod 00755 DIRECTORY
8. sticky bit is lowercase "t" when there is an x (execute) bit also
9. sticky bit is uppercase "T" if it is just sticky with no x
