#  Create and use templates to create customized configuration files

## Objective
* Use advanced Ansible features
	* Create and use templates to create customized configuration files

---
## Implementation
* [interfaces.j2](interfaces.j2)
* [hosts.j2](hosts.j2)

### Useful Information
* JINJA2 is a template, which is a config file that contains variables, is generated on managed hosts according to host specific requirements
* JINJA2, files can end with TEMPLATE.j2
* JINJA2 dir can be in project named "templates" and hold template files they are automatically found in "templates" and maybe project dir

* Using templates allows for a structural way to generate config files
*  Ansible uses JINJA2, which is a generic templating language for python developers. It isn't only found in templates, but also the way VARS are referred to is based on JINJA2
*  JINJA2 templates, 3 elements can be used in them
	* data, sample text
	* comment, {# sample text#}
	* variable, {{ansible_fact['default_ipv4']['address']}}
	* expression,
		- {% for my host in groups['web']%}
		- {{ myhost }}
		- {% endfor %}

* JINJA2 templates must be written in jinja2, then this template file must be included in an ansible-playbook that uses the TEMPLATE: module
* JINJA2 TEMPLATES, start with "#{{ ansible_managed }}", a commonly used string to signify that it is managed by ansible (for admins)
* when the TEMPLATE is processed, the string is replaced by the "ansible_managed" VAR found in ansible.cfg
	* ansible_managed = "This file is managed by USER"

* FILTERS, can be used in JINJA2 to perform operations on the value of a template expression, such as a VAR. The filter is included in the VAR definition itself and the result of both is used in the file that is generated

* common FILTERS:
	*  {{my_var|to_json}}, writes content of myvar into JSON
	* {{my_var||to_yaml }}, writes content of myvar into YAML
	* {{my_var|ipaddr}}, test whether myvar contains an IP address
*  FILTERS to set a default
	* {{ var | default(5) }} (sets var to 5 if it is undefined)
	* defaults/main.yml (inside a role...if i get there)

* playbooks fail if VARS are undefined. you can change this behavior with:
	* DEFAULT_UNDEFINED_VAR_BEHAVIOR = false
* Then use a FITLER to make sure some VARS are mandatory
	* {{ var | mandatory }}
	* Use a FILTER to change the DATA TYPE from one to another
	* {{ dictionaryVAR | dict2items }} = turn to items for looping

* there should be NO spaces on either side of the pipes
	* "{{ var|dict2items }}" 
	* "{{ var|dictsort }}"
	* it will FAIL otherwise
* WHEN looping OVER A DICTIONARY, it can be provided by the above
	* with_dict or its loop replacements but that creates a loop on a loop which is idempotent but not necessary
* DEFINE A DICTIONARY in or on a template as a VAR in the header
	* vars_files: dictionary.yml
* use {% for key, value in _dict.iteritems() %} if you need both key and value in the template


*  JINJA2, has one CONDITIONAL IF with ELIF and ELSE
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

* check docs for items2dic
*  also force DATA TYPES
	* when: somevar | bool
	* when: somvar | int
*  FILTER to switch formats
	* {{ somevar | to_json }}
	* {{ somevar | to_yaml }}
	* {{ somevar | from_json }}
	* {{ somevar | from_yaml }}
*  FILTER to HASH AND ENCRYPT a STRING
	* {{ 'test1' | hash('md5') }}
		* => "5a105e8b9d40e1329780d62ea2265d8a"
	* {{ 'passwordsaresecret' | password_hash('sha512') }}
		* => "$6$UIv3676O/


### Useful Modules
* template:

### Useful Commands

### Useful Directories/Files

### Useful Packages

---

## Notes
1. Test **is boolean** works with keyword:value paris defined as "True/False". They also evaluate to true with:
	* **is number**
	* **True == 1**
	* **False == 0**
2. Maybe useful -- using the following learn how tests get parsed:

```yaml
when: keyword is == 0
```

* returns
	* the conditional check 'keyword is == 0' failed. The error was: templating error while templating string: expected token 'name', got '=='. String:


```yaml
{% if keyword is ==0 %} True {% else %} False {% endif %}
```

