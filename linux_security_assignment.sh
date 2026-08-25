#!/bin/bash
# ============================================================
# Linux Security & Scheduling Assignments (1, 2, and 3)
# ============================================================

# Assignment 1: Shared Department Directory & Backup
groupadd developers; groupadd testers; groupadd managers
useradd -G developers dev01; useradd -G developers dev02
useradd -G testers test01; useradd -G testers test02
useradd -G managers manager01
mkdir -p /company/projects
chown manager01:managers /company/projects
chmod 3770 /company/projects
setfacl -m g:developers:rwx,g:testers:rx,g:managers:rwx /company/projects
setfacl -d -m g:developers:rwx,g:testers:rx,g:managers:rwx /company/projects
touch /company/projects/project-plan.txt
chattr +i /company/projects/project-plan.txt
mkdir -p /backup/projects
(crontab -l 2>/dev/null; echo "0 2 * * * rsync -avz /company/projects/ /backup/projects/") | crontab -

# Assignment 2: Secure Application Configuration & Backups
groupadd appadmins; groupadd appusers; groupadd backupadmins
useradd -G appadmins appadmin; useradd -G appusers appuser
useradd -G backupadmins backupuser; useradd -G appusers developer
mkdir -p /opt/myapp/{config,logs,data,scripts}
chown -R appadmin:appadmins /opt/myapp
chmod -R 750 /opt/myapp
setfacl -R -m u:appuser:r-x,u:developer:r-x,u:backupuser:r-x,d:u:backupuser:r-x /opt/myapp
setfacl -m u:appuser:rwx,d:u:appuser:rwx /opt/myapp/logs /opt/myapp/data
chmod 2770 /opt/myapp/logs /opt/myapp/data
touch /opt/myapp/config/application.conf
chattr +i /opt/myapp/config/application.conf
mkdir -p /backup/myapp
(crontab -l 2>/dev/null; echo "0 23 * * * tar -czf /backup/myapp/config-\$(date +\%Y-\%m-\%d).tar.gz -C /opt/myapp config && find /backup/myapp -name 'config-*.tar.gz' -mtime +7 -delete") | crontab -

# Assignment 3: Server Security & Compliance Automation
groupadd security; groupadd auditors; groupadd operators
useradd -G security security01; useradd -G auditors auditor01
useradd -G operators operator01; useradd -G security admin01
mkdir -p /security/{confidential,reports,audit,scripts}
chmod 700 /security/confidential
setfacl -m u:admin01:rwx,u:security01:rwx,u:auditor01:rx,u:operator01:--- /security/confidential
chmod 3770 /security/audit
setfacl -d -m g:security:rwx,g:auditors:rx /security/audit
touch /security/confidential/security-policy.txt
chattr +a /security/confidential/security-policy.txt
echo '{ date; hostname; ls -ld /security/*; getfacl -R /security; lsattr -R /security; } >> /var/log/security_check.log' > /usr/local/bin/security_check.sh
chmod +x /usr/local/bin/security_check.sh
(crontab -l 2>/dev/null; echo "0 1 * * * /usr/local/bin/security_check.sh") | crontab -
