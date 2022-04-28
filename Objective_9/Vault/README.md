#  Use Ansible Vault in playbooks to protect sensitive data

## Objective
* Use advanced Ansible features
	*  Use Ansible Vault in playbooks to protect sensitive data

---

### Useful Information
* ANSIBLE VAULT, to deal with sensitive data, used to encrypt/decrypt files
	* makes sense to store encrypted and unencrypted vars in diff files and use group_vars host_vars variable inclusion
	* while separating encypted vars from unencrypred vars, inside the host_vars/group_vars DIR you may create a DIR (instead of a file) with the name of the host/hostgroup. Inside that DIR create two files:
		* "vars" = for unencrypted VARS
		* "vault" = encypted VARS
	* FILE STRUCTURE == project/host_vars/HOSTNAME/vars + vault (files)

* OR vault encrypred VARS can be included from a file using the parameter "vars_files"
	* passwords are stored as values in VARS in a separate VAR file
	* VAR file is encryped using ansible-vault
	* while accessing var file from a playbook you use a password to decrypt
	* ansible-vault create playbook.yml
	* get rid of passwords by putting them in a VAULT PASSWORD FILE which is placed in a secure place like /root 

* --vault-id @prompt:
	* option to be prompted for password to run a playbook that accesses vault encrypted files

* encrypted files CAN have different passwords
	* --ask-vault-pass = if all have the same password
	* --vault-password-file=FILENAME = store the PW in a single-line string in a PW file and use that to view/edit etc vault encrypted files



### Useful Modules
* vars_files: /path (in header)

### Useful Commands
```zsh
echo 'alias av=ansible-vault' >> .bashrc
```

* ansible-vault create --vault-password-file=vault-pass playbook.yml
* ansible-vault encrypt existing_file.yml (to encrypt 1 or more existing files)
* ansible-vault decrypt (unencrypt)
* ansible-vault encrypt_string (single string)
* ansible-vailt rekey (change password)
* ansible-vault view (show contents of encrypted file)
* ansible-vault edit (edit encrypted file)


### Useful Directories/Files

### Useful Packages

---

## Notes
1. The passwords MUST be hashed to send them through ansible user: password:, I first created the hash and then echoed it into the file.

```zsh
echo 'openssl passwd -6 PASSWORD' >> users.yml
```

```zsh
ansible-playbook vault_encrypted_passwords.yml --vault-password-file=vault_pass.txt
```

```zsh
ansible-playbook delvault_encrypted_passwords.yml --vauld-id @prompt
```


