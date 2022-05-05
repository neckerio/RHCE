# Plugins and Filters

## Objective
* EXTRA

---

### Implementation
* [lookup_query.yml](lookup_query.yml)
* [loop_customfacts.yml](loop_customfacts.yml)
* [loop_customfacts_alt.yml](loop_customfacts_alt.yml)
* [delloop_customfacts.yml](delloop_customfacts.yml)

### Useful Information
* Filter plugins manipulate data. With the right filter you can extract a particular value, transform data types and formats, perform mathematical calculations, split and concatenate strings, insert dates and times, and do much more. Ansible uses the standard filters shipped with Jinja2 and adds some specialized filter plugins. You can create custom Ansible filters as plugins.

* Lookup plugins are an Ansible-specific extension to the Jinja2 templating language. You can use lookup plugins to access data from outside sources (files, databases, key/value stores, APIs, and other services) within your playbooks. Like all templating, lookups execute and are evaluated on the Ansible control machine. Ansible makes the data returned by a lookup plugin available using the standard templating system. You can use lookup plugins to load variables or templates with information from external sources. You can create custom lookup plugins.
 
* the LOOP keywords requires a LIST as input, BUT the LOOKUP keyword returns a string of comma-separated values by default
 
* the QUERY keyword always returns a list, more predictable and a simpler interface with LOOP
 
* LOOKUP can be forced to return a list by using wantlist=True OR just use QUERY
 
 


### Useful Plugins/Filters [^examples]
* {{ myvar | type_debug }}
* {{ dict | dict2items }}
* {{ files | dict2items(key_name='file', value_name='path') }}
* {{ tags | items2dict }}
* {{ tags | items2dict(key_name='fruit', value_name='color') }}
* {{ default | combine(patch, list_merge='append') }} 
	* add __patch__ to **default** list
* {{ default | combine(patch, list_merge='prepend') }}
* {{ default | combine(patch, list_merge='append_rp') }}
	* add __patch__ to **default** list and remove previous hash
* {{ default | combine(patch, list_merge='prepend_rp') }}

### Useful Commands
* ansible-doc -t lookup -l (list all lookup plugins and small explanation!)
* ansible-doc -t lookup PLUGIN (for specific information)
* ansible-doc -s (show a small explanation/snippet for specified option in a pager) faster than piping into a less, I guess)
 

### Useful Directories/Files
* /etc/ansible/facts.d/
* ANSIBLE DOCS = FILTERS

### Useful Packages

---

## Notes
1. Discovered a loop Alternative to json_query, using dict2items. In implementation as ALT
2. Maybe that is what happens in the background when **ansible.cfg** has the option ***stdout_callback = yaml*** set?

---
[^examples]: examples can be found in [Ansible Docs](https://docs.ansible.com/ansible/latest/user_guide/playbooks_filters.html#formatting-data-yaml-and-json)
