# Manage Parallelism

## Objective
* Install and configure an Ansible control node
	*  Manage parallelism
	
---

### Implementation
* [async.yml](asnyc.yml)

### Useful Modules
* command:
	* cmd:
* async_status:
	* jid:
	* mode: (status/cleanup)

### Useful Commands
* ansible-playbook playbook.yml -f #
* ansible all -B 60 -P 10 -a "/usr/bin/SOME_CMD"
* ansible-doc -t strategy -l

### Useful Directories/Files
* ansible.cfg
	* [defaults]
	* forks = (DEFAULT=5)
	* strategy = (DEFAULT=linear,free,debug)

### Useful Packages

---

## Notes
* KEY-IDEAS = Async/Poll[^async], Forks, Strategies[^strategies], Keywords of Execution
* Parallel Task Execution, manages the number of Hosts on which tasks are executed simultaneously

> By default, Ansible runs each task on all hosts affected by a play before starting the next task on any host, using 5 forks. If you want to change this default behavior, you can use a different strategy plugin, change the number of forks, or apply one of several keywords like serial.


* Serial Task Execution, can be used to make sure that all tasks are executed on a host or group of hosts BEFORE proceeding to the next hosts or group of hosts
* Asynchronous Mode, best used for long-running shell commands or software upgrades, and helps avoid timeouts etc.

> If you want to run multiple tasks in a playbook concurrently, use async with poll set to 0. When you set poll: 0, Ansible starts the task and immediately moves on to the next task without waiting for a result. Each async task runs until it either completes, fails or times out (runs longer than its async value). The playbook run ends without checking back on async tasks.

> In addition to strategies, several keywords also affect play execution. You can set a number, a percentage, or a list of numbers of hosts you want to manage at a time with serial. You can restrict the number of workers allotted to a block or task with throttle. You can control how Ansible selects the next host in a group to execute against with order. You can run a task on a single host with run_once. These keywords are not strategies. They are directives or options applied to a play, block, or task.



---
[^async]: general information in [Ansible Docs](https://docs.ansible.com/ansible/latest/user_guide/playbooks_async.html)

[^strategies] general information in [Ansible Docs](https://docs.ansible.com/ansible/latest/user_guide/playbooks_strategies.html)
