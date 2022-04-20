# Archiving

## Objective
* Use Ansible modules for system administration tasks that work with:
	* Archiving 
	  
---

### Implementation
* [archive.yml](archive.yml)
* [delarchive.yml](delarchive.yml)

### Useful Modules
* archive:
	* dest:
	* force_archive:
	* format: (gz,bz2,tar,xz,zip)
	* group:
	* mode:
	* owner:
	* path:
	* remove: (after adding to archive)
	* exclude_path:
	* exclude_patterns:
* unarchive:
	* creates: (if specified path already exists do **NOT** create)
	* dest: /absolute/path/unpack
	* group:
	* keep_newer: BOOL
	* list_files: BOOL
	* mode:
	* owner:
	* remote_src: BOOL
	* src:
	* include:
	* exclude: item1,item2,item3

### Useful Commands

### Useful Directories/Files

### Useful Packages
* rsync

---

## Notes
1. **archive:** module's attributes to control ownership may be needed when using become
2. **archive:** module's attribute **include:** is throwing errors. Not sure why. Hope I don't have to care.
3. Hopefully, the URL used to download the Linux Kernel doesn't change, it will ruin the idempotency of the delarchive.yml removal


---

