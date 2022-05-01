# Configure error handling

## Objective
* Create Ansible plays and playbooks
	* Configure error handling

---

### Implementation
* [errors.yml](errors.yml)

### Useful Modules
* block:
	* rescue:
	* always:
* fail:
	* msg:
* failed_when:
* ignore_errors:
* force_handlers:
* any_errors_fatal:

### Useful Commands

### Useful Directories/Files

### Useful Packages

---

## Notes
1. BLOCKS, a logical group of tasks. Can be used to control how tasks are executed
	* one BLOCK can be enabled using a single WHEN
	* so a BLOCK is a group of tasks to which a WHEN statement can be applied
2. place "block:" between "tasks:" statement in playheader and the actual tasks that run the specific module
3. **block:** also can be used in ERROR CONDITION HANDLING:
	* use BLOCK to define main task to run
	* use RESCUE to define tasks to run if BLOCK Fails
	* use ALWAYS to run always, no matter if BLOCK or RESCUE Succeed or Fail
4. ITEMS can Not be used in BLOCKS
5. you CANNOT use a BLOCK on a LOOP
6. BLOCK is placed and behaves as a sort of Super TASK
7. if BLOCK and WHEN statements are placed on the same level, the tasks in the block Activate only if the WHEN statement is true.
8. FAILURE Handling using TASK CONTROL
	* ansible looks at the exit status of a task to determine failure
	* when any task fails, ansible aborts the play on that host and continues to the next host. Different ways to change the above behavior
	* ***ignore_errors:*** = ignore failures
	* ***force_handlers:*** = force handler to run despite failure IT MAY NOT FORCE ON SUCCESS status or GREEN though!!!!!!!!!!!
9. DEFINING Failure States, ansible Only looks at the EXIT STATUS of a failed task, it may think a task was successful even when it wasn't.
	* use failed_when = to specify what to look for in a command output to recognize a failure
	* ***FAILED_WHEN*** is a true conditional, must be used to evaluate an expression
	* fail, MODULE can be used to print a msg about failure
	* fail_when cannot give these specific messages
	* to use these two the result of the command Must be REGISTERED and the output analyzed
10. when using **fail:** module, the failing task must have ***ignore_errors:*** set to yes
11. ANY ERRORS FATAL, stop entire playbook if there are any errors, so that the play isn't half done.
	* ***any_errors_fatal:***, in block or in play header

