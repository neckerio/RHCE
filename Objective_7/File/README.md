# File Content

## Objective
* Use Ansible modules for system administration tasks that work with:
	*  File content

---

### Implementation
* [files.yml](files.yml)
* [delfiles.yml](delfiles.yml)

### Useful Modules
* file:
	* group:
	* mode:
	* owner:
	* path:
	* recurse: (if directory)
	* src: (for links)
	* state:
		* absent
		* directory (-p implicit)
		* file (modified OR state of path)
		* touch (create file)
		* hard (hard link)
		* link (symbolic)
		* src (for links)
	* backup: BOOL
* blockinfile:
	* block:
	* create:
	* group:
	* insertafter:
	* insertbefore:
	* mode:
	* owner:
	* path:
	* state: (present/absent)
	* validate:
* stat
	* path:
* find
	* age: (s,m,h,d,w)
	* age_stamp: (atime,ctime,mtime)
	* contains: (regex)
	* excludes: (regex)
	* file_type: (any,directory,file,link)
	* hidden: BOOL
	* paths:
	* size:
* lineinfile
	* backup: BOOL
	* create:
	* firstmatch: (/w insertafter/instertbefore)
	* group:
	* insertafter: (after last match)
	* insertbefore: (before last match)
	* line:
	* mode:
	* owner:
	* path:
	* regex:
	* search_string:
	* state: (present/absent)
	* validate:
* copy:
	* backup: BOOL
	* content:
	* dest:
	* force:
	* group:
	* mode:
	* owner:
	* remote_src:
	* src: (local path)
	* validate:
* fetch:
	* dest: (adds remote host name to avoid conflicts)
	* flat: (override default dest: behavior)
	* src: (file only)
* synchronize
	* archive: BOOL
	* compress: BOOL
	* dest:
	* existing_only: BOOL (don't create new files)
	* group:
	* mode:
	* owner:
	* private_key: (ssh)
	* recursive: BOOL
	* set_remote_user:
	* src:
* replace:
	* after: (replace after this match)
	* backup: BOOL
	* before: (replace before this match)
	* group:
	* mode:
	* owner:
	* path: (file to mod)
	* regexp:
	* replace: (what to replace regex with)
	* validate:
* template:
	* backup: BOOL
	* dest:
	* force:
	* group:
	* mode:
	* owner:
	* src:
	* validate:


### Useful Commands

### Useful Directories/Files
* ~/.vimrc
* ~/.bashrc
* /etc/ssh/sshd_config

### Useful Packages

---

## Notes
1. **file:** module's attribute **regexp:** can remove multiple lines if attribute **state:** is absent
2. [files.yml](files.yml) contains a loop through _groups['all'][x]_ with x being different numbers in the array. There is probably a cleaner way to do this.
