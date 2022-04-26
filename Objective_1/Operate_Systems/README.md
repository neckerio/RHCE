# Operate running systems

## Objective RHCE
* Be able to perform all tasks expected of a Red Hat Certified System Administrator
	*  Operate running systems

## Objective RHCSA
* Operate running systems
	* [Boot, reboot, and shut down a system normally](Objective_1/Deploy_Maintain_Systems)

        * [Boot sys
ems into different targets manually](Objective_1/Deploy_Maintain_Systems)
        * [Interrupt the boot process in order to gain access to a system](Objective_1/Deploy_Maintain_Systems)
        * Identify CPU/memory intensive processes and kill processes
        * Adjust process scheduling
        * Manage tuning profiles
        * Locate and interpret system log files and journals
        * Preserve system journals
        * Start, stop, and check the status of network services
        * Securely transfer files between systems

---

### Useful Information
#### process
* niceness ranges from -20 to 19
* higher niceness is more nice (less important)
* rt is highest priority
* nice/renice needs sudo
* I have similar information for tuned in tuningProfiles.txt



#### tuned
* power profiles for different use cases (gaming/text editing etc.) to ttune battery/resources.



#### log
* each logger line in rsyslog contains three items
	* facility = the specific facility the log is created for
	* severity = the severity from which it is logged
	* destination = the destination the log is to be written to


#### services
* systemctl (that is all I wrote?)


### Useful Commands
#### process
* while true; do true; done & (make a loop)
* dd if=/dev/zero of=/dev/null (another loop)
* CTRL Z; bg (run in background)
* jobs
* fg #
* ps (overview of processes)
* ps aux (overview of all processes)
* ps fax (hierarchical relation between processes) 
* ps -fU user (processes by user)
* ps -f --forest -C sshd (show process tree for specific process)
* ps -L (show process threads)
* ps L (format specifiers)
* ps -eo pid,ppid,user,cmd (uses some of the specifiers to show a list of processes)
* free -m (free memory)
* uptime (how long the system has been up)
* watch uptime (refreshes every 2 seconds, monitor)
* lscpu (info about cpu, socket, thread, core,)
* top
	* f (select available display fields)
	* M (filter by mem usage)
	* W (save new display settings)
	* k (send signal; ENTER (biggest) or PID; then SIGNAL
	* r (renice pid)
* kill PID (default 15/SIGTERM)
* nice -n -10 dd if=/dev/zero of=/dev/null
* renice -n -15 PID 
* pgrep (grep processes by different criteria)
* pkill (send signal to each process instead of listing them to stdout)
* pwait (wait for process instead of listing on stdout
* killall (kill all processes by command name)
* systemctl status tuned
* tuned-adm list (show profiles list)
* tuned-adm profile NAME (set a specific profile)
* tuned-adm active (show curren profile)
* top -b > topSnapShot.txt
	* top; k (send kill sig); 15/9 (specific sig)
	* kill -l (view all signals)
	* jobs; kill -sigstop %1; ps aux | grep pid
	* pgrep -u tanya -l bash

* WALKTHROUGH in NOTES



#### tuned
* systemctl status tuned
* tuned-adm
* tuned-adm list2 
* tuned-adm active
* tuned-adm recommend

* change the profile to desktop (this should persist after reboot)
	* tuned-adm profile desktop; tuned-adm active (verify)



#### log
* logger text
* tail /var/log/secure (follow logs for people authenticating)
* tail -f /var/log/secure (follow auth logs live)
* systemctl status systemd-journald 
* journalctl
* journalctl TABTAB
* systemctl status systemd-journald (for journaling)
* journalctl --since 09:30
* journalctl --unit httpd; journalctl --unit sshd
* journalctl -p crit; (emerge,alert,crit,err,warning,notice,info,debug)
* journalctl -x (add catalog, explanatory text to logs)
* journalctl -e (jump to end of pager)
* journalctl -u (show journal for specific unit)
* journalctl -f (follow journal)
* journalctl -g (grep for expression)
* journalctl -r (display output in reverse)

* WALKTHROUGH in NOTES to make JOURNALD PERSISTENT



#### rsync (secure file transfer)
* rsync -r (recursively sync entire dir tree)
* rsync -l (sync sym links)
* rsync -p (preserve sym links)
* rsync -n (dry run)
* rsync -a (archive mode, perserve almost everything. similar to -rlptgoD)
* rsync -A (archive mode, including ACLs)
* rsync -X (syc SELinux contexts)
* rsync -avP (archive, verbose, progress)
* rsync -avP -e "ssh -i .ssh/null_id_ed25519" test.md name@null:/home/USER/
	* copies test.md to remote server using ssh
* rsync -avP -e "ssh -i .ssh/null_id_ed25519" name@null:/home/USER/test.jpg /home/USER
	* copy test.jpg from remote server to local server using ssh (use remote server as input this time, it comes first)

* SCP
* copy file to remote computer
	* scp test.txt USER@ip.add.re.ss:~
* copy file from remote computer (second address is TO)
	* scp USER@ip.add.re.ss:~/test.txt /home/USER/local
* copy recursively entire /etc directory
	* scp -r USER@ip.add.re.ss:/etc /home/USER/local

* WALKTHROUGH SFT ALT IN NOTES



### Useful Directories/Files
#### process
* man 7 signal

#### tuned
* /usr/lib/tuned (inside, find different directories for different profiles offered along with a description of what hey do)


#### log
* /etc/rsyslog.conf (tells you where particular logs are stored)
* /etc/rsyslog.d (store snap-in files can be stored)
* /var/log (variety of logs)
	* secure = auth
	* audit = SELinux problems (often here)
* /etc/systemd/journald.conf
* man systemd-journald
* mkdir /var/log/journal (MAKE JOURNALD PERSISTENT!!!)
* /etc/logrotate.d (snap-in files)
* /etc/logrotate.conf



### Useful Packages
#### process / tuned
* tuned


#### log
* rsyslog





---

## Notes
1. Process Schedule (real time scheduler)
	* chrt (change real time)
	* chrt --help
	* chrt -p (give you scheduler the PID is using) 
* list process schedule of a particular process
	* for i in $(pgrep httpd); do chrt -p $i; done
	* chrt -f -p 10 PID (fifo scheduler with -f, applied to PID)
	* chrt -o -p 0 PID (sched_other, most common)
* they aren't persistent, make persistent
	* vim /usr/lib/systemd/system/httpd.service
		* [Service]
		* Type=notify
		* Environment=LANG=C
		* CPUSchedulingPolicy=fifo (example)
		* CPUSchedulingPriority=10 (example)
	* systemctl daemon-reload; systemctl restart httpd (verify to survive reboot)	


2. journald is not persistent, it start fresh on reboot, make it
* mkdir /var/log/journal (after making the directory is should store logs in there and persist after reboot)
* systemctl restart systemd-journald 
	* after making it persistent and a reboot, the permissions will change on the journal directory. It will be owned by systemd-journal
* vim /etc/systemd/journald.conf (edit the /etc/systemd/journald.conf)
	* STORAGE=persistent (will store in /var/log/journal or create it)
		* volatile (stores only in /run/log/journal)
		* auto (stores it in /var/log/journal if it exists, if it doesn't then in /run/log/journal) 


3. Secure File Transfer Protocol (sftp) (interactive)
* show local working directory
	- >?
	- >lpwd
* change local current directory
	- >?
	- >lcd /path/to/dir

* show remote working directory
	- >?
	- >pwd
* change remote working directory
	- >?
	- >cd /path/to/dir

* copy file to remote computer
	- sftp USER@ip.add.re.ss
	- >?
	- >put test.txt

* copy file from remote computer
	- sftp DIFFUSER@ip.add.re.ss
	- >?
	- >get test.txt

* exit
	- >?
	- >exit



