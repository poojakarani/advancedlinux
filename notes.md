# Linux User Management & Administration Lab

This repository contains the practical implementation and verification for User Provisioning, Modification, and Password Aging policies on Red Hat Enterprise Linux.

---

## Assignment 1: Basic User Account Provisioning

### Objectives
- Create a standard user account `devuser01` with a dedicated home directory and standard Bash shell.
- Verify group associations and passwd database entries.
- Verify interactive login and file creation permissions.

### Commands Executed
```bash
# Create user with home directory and bash shell
useradd -m -s /bin/bash devuser01

# Set user password
passwd devuser01

# Verification commands
id devuser01
groups devuser01
grep devuser01 /etc/passwd

# Switch user and test file creation
su - devuser01
pwd
touch welcome.txt
ls -l welcome.txt
exit
```
### Verification Evidence
<img width="1280" height="800" alt="linux assignment 01" src="https://github.com/user-attachments/assets/e6fa1fdf-fe69-4cbd-bd48-c07c95248d85" />

---

## Assignment 2: User Account Modification with `usermod`

### Objectives
- Provision `support01` and update GECOS comments, shell, and home directory location.
- Create supplementary group `appops` and attach `support01` without affecting primary groups.
- Test account locking and unlocking mechanisms.

### Commands Executed
```bash
# Provision user
useradd -m -s /bin/bash support01
passwd support01

# Modify metadata, shell, and home directory
usermod -c "Support User, Application Operations" support01
usermod -s /bin/sh support01
usermod -d /home/appsupport01 -m support01

# Add supplementary group
groupadd appops
usermod -aG appops support01

# Test lock and unlock
usermod -L support01
passwd -S support01
usermod -U support01
passwd -S support01

# Final verification
id support01
grep support01 /etc/passwd
```
### Verification Evidence
<img width="1280" height="800" alt=" linux assignment 02" src="https://github.com/user-attachments/assets/acbfbe2d-544f-4cc6-af70-dc4b7b7d739f" />

---

## Assignment 3: Password and Account Aging Policies with `chage`

### Objectives
- Provision `contractor01`.
- Enforce password rotation intervals, warning periods, inactivity window, and explicit account expiration.
- Force password update on next interactive login.
- Compare specific user policies with `/etc/login.defs` defaults.

### Commands Executed
```bash
# Provision user
useradd -m -s /bin/bash contractor01
passwd contractor01

# View initial defaults
chage -l contractor01

# Apply aging policy: min 7d, max 90d, warn 14d, inactive 30d, expire 2026-12-31
chage -m 7 -M 90 -W 14 -I 30 -E 2026-12-31 contractor01

# Force password change at next login
chage -d 0 contractor01

# Verify updated policy
chage -l contractor01

# Inspect system-level baseline defaults
grep -E '^PASS_MAX_DAYS|^PASS_MIN_DAYS|^PASS_WARN_AGE' /etc/login.defs
```
### Verification Evidence
<img width="1280" height="800" alt="linux assignment 03" src="https://github.com/user-attachments/assets/b2b87e7d-6968-4203-8c77-32553606978e" />

