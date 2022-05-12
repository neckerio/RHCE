# Use conditionals to control play execution

## Objective
* Create Ansible plays and playbooks
	*  Use conditionals to control play execution

---

### Implementation
* [conditionals.yml](conditionals.yml)
* [delconditionals.yml](delconditionals.yml)

### Useful Modules
* when: 
	* when: ansible_machine == "x86_64"
	* when: ansible_distribution_major_version == "8"
	* when: ansible_memfree_mb == 1024 (INTEGER no need for quotes)
	* when: ansible_memfree_mb < 256
	* when: ansible_memfree_mb > 256
	* when: ansible_memfree_mb >= 256
	* when: ansible_memfree_mb != 512
	* when: my_variable is defined (boolean)
	* when: my_variable is not defined 	
	* when: ansible_distribution in supported_distros (check if first VAR is expressed as a value in second VAR)
	* when: text == "hello" INSTEAD OF when: "{{text}}" == "hello"
	* when: ansible_facts[’os_family’] == "RedHat"
	 
	* when: ansible_distribution == "CentOS" or ansible_distribution == "RedHat"	
	* when: ansible machine == "x86_64" and ansible_distribution == "CentOS"
* changed_when:

* JINJA2, has one CONDITIONAL IF with ELIF and ELSE
	* value comparisons
		* ==
		* !=
		* >
		* >=
		* <
		* <=
	* logical operators
		* and
		* or
		* not
	* tests (write "is" + test name) JINJA2 doc has all bultin tests
	* these tests can be added inline to the FOR loop
		* is defined
		* is boolean
		* is float
		* is number (both int/float)
		* is string
		* is mapping (dictionary)
		* is iterable (can be iterated over; string, dict, list etc.)
		* is sequence
	* also IN to test if an element exists in a list or a key exists in a dictionary
		* {% if 'Loopback0' in interfaces -%}



### Useful Commands

### Useful Directories/Files

### Useful Packages

---

## Notes
1. **when:** at the Module level. 4 types of tests
	* Check VAR EXISTENCE
	* Check BOOLEAN
	* Compare STRINGS
	* Compare INTEGERS
2. MULTIPLE CONDITIONS evaluated by when, group the statements with parentheses () and combine them with AND/OR keywords
3. Playbook Vars, REGISTER Vars, and FACTS can be used in conditions and make sure tasks only run if specific conditions are true
4. When used in WHEN statements, VARS don't need to be in {{}} just the "" indicate it is a STRING TEST if no "" are present it is an INTEGER TEST
5. LOOPS and CONDITIONALS can be combined iterate through a list of dictionaries and apply the conditonal statement only if a dictionary is found that matches the condtion
6. ***changed_when:*** allows Ansible to report CHANGED Status where it otherwise normally wouldn't be, allowing handlers to be triggered
7. using CHANGED_WHEN is usable in two cases: 
	* changed_when: false, only reports a OK or FAILED status never a changed
	* to run handlers when change normally isn't triggered
8. If the CONDITIONALS don't exist, they are SKIPPED.

