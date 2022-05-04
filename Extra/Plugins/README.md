# Plugins

## Objective
* EXTRA

---

### Implementation
* [lookup_query.yml](lookup_query.yml)
* [loop_customfacts.yml](loop_customfacts.yml)
* [delloop_customfacts.yml](delloop_customfacts.yml)

### Useful Information
* Filter plugins manipulate data. With the right filter you can extract a particular value, transform data types and formats, perform mathematical calculations, split and concatenate strings, insert dates and times, and do much more. Ansible uses the standard filters shipped with Jinja2 and adds some specialized filter plugins. You can create custom Ansible filters as plugins.

* Lookup plugins are an Ansible-specific extension to the Jinja2 templating language. You can use lookup plugins to access data from outside sources (files, databases, key/value stores, APIs, and other services) within your playbooks. Like all templating, lookups execute and are evaluated on the Ansible control machine. Ansible makes the data returned by a lookup plugin available using the standard templating system. You can use lookup plugins to load variables or templates with information from external sources. You can create custom lookup plugins.
 
* the LOOP keywords requires a LIST as input, BUT the LOOKUP keyword returns a string of comma-separated values by default
 
* the QUERY keyword always returns a list, more predictable and a simpler interface with LOOP
 
* LOOKUP can be forced to return a list by using wantlist=True OR just use QUERY
 
 


### Useful Modules

### Useful Commands
* ansible-doc -t lookup -l (list all lookup plugins and small explanation!)
* ansible-doc -t lookup PLUGIN (for specific information)
* ansible-doc -s (show a small explanation/snippet for specified option in a pager) faster than piping into a less, I guess)
 

### Useful Directories/Files
* /etc/ansible/facts.d/

### Useful Packages

---

## Notes
