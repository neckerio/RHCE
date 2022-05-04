# ACL

## Objective: EXTRA
* Apply ACL's like a lifeless drone
---
### Implementation
* [acl.yml](acl.yml)
* [delacl.yml](delacl.yml)

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

### Useful Directories/Files

### Useful Packages

---

## Notes
1. Important to set both DEFAULT and without it. 
2. It is possible to use "remote_user: USER", at the same lvl as register: in the task section, to try creating a file on the remote nodes. Requires SSH keys and I am lazy. This may not even be on the test
