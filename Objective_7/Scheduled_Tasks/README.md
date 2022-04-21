# Scheduled Tasks

## Objective
* Use Ansible modules for system administration tasks that work with:
	*  Scheduled tasks

---

### Implementation
* [scheduled.yml](scheduled.yml)
* [delscheduled.yml](delscheduled.yml)

### Useful Modules
* cron:
	* backup: BOOL
	* day:
	* disabled: BOOL
	* hour:
	* job: 
	* minute:
	* month:
	* name: (description)
	* reboot: (run on reboot) BOOL
	* special_time: (hourly, reboot, weekly etc)
	* user: (whose crontab?)
	* weekday:
* at:
	* command:
	* count: (# of units in the future to exec cmd)
	* script_file:
	* state: p/a
	* units: (minutes, hours, day, week)
	* unique: BOOL

### Useful Commands
* crontab -e
* crontab -l
* anacron
* sudo atq
* atrm
* tail -f /var/log/messages
* /usr/sbin/crond

### Useful Directories/Files
* /etc/crontab
* /etc/anacrontab
* /etc/cron.deny
* /etc/at.deny
* /etc/cron.allow
* /etc/at.allow
* /var/log/messages
* /var/spool/at
* /var/spoo/cron/

### Useful Packages
* cron
* at

---

## Notes
1. Need to find a way to remove the entire queue from 'at' on the command line
