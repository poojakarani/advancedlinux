  299  git add file_io_assignment2
  300  git status
  301  rm -rf file_io_assignment2/file_io_assignment2
  302  git add .
  303  git commit -m "Add Assignment 2 files"
  304  git push origin main
  305  poweroff
  306  history
  307  poweroff
  308  groupadd developers; groupadd testers; groupadd managers
  309  useradd -G developers dev01; useradd -G developers dev02
  310  useradd -G testers test01; useradd -G testers test02
  311  useradd -G managers manager01
  312  mkdir -p /company/projects
  313  chown manager01:managers /company/projects
  314  chmod 770 /company/projects
  315  setfacl -m g:developers:rwx,g:testers:rx,g:managers:rwx /company/projects
  316  setfacl -d -m g:developers:rwx,g:testers:rx,g:managers:rwx /company/projects
  317  chmod 3770 /company/projects
  318  touch /company/projects/project-plan.txt
  319  chattr +i /company/projects/project-plan.txt
  320  ls -ld /company/projects; getfacl /company/projects; lsattr /company/projects/project-plan.txt
  321  mkdir -p /backup/projects
  322  (crontab -l 2>/dev/null; echo "0 2 * * * rsync -avz /company/projects/ /backup/projects/") | crontab -
  323  clear
  324  groupadd admins; groupadd appusers; groupadd backupadmins
  325  useradd -G appadmins appadmin; useradd -G appusers appuser
  326  groupadd appadmins; groupadd appusers; groupadd backupadmins
  327  useradd -G appadmins appadmin; useradd -G appusers appuser
  328  useraadd -G backupadmins backupuser; useradd -G appusers developers 
  329  usradd -G backupadmins backupuser
  330  useradd -G appusers developer
  331  id appadmin; id appuser; id backupuser; id developer
  332  useradd -G backupadmins backupuser
  333  id backupuser
  334  mkdir -p /opt/myapp/{config,logs,data,scripts}
  335  chown -R appadmin:appadmins /opt/myapp
  336  chmod -R 750 /opt/myapp
  337  setfacl -R -m u:appuser:r-x,u:developer:r-x,u:backupuser:r-x,d:u:backupuser:r-x /opt/myapp
  338  setfacl -m u:appuser:rwx,d:u:appuser:rwx /opt/myapp/logs /opt/myapp/data
  339  chmod 2770 /opt/myapp/logs /opt/myapp/data
  340  touch /opt/myapp/config/application.conf
  341  chattr +i /opt/myapp/config/application.conf
  342  lsattr /opt/myapp/config/application.conf
  343  mkdir -p /backup/myapp
  344  (crontab -l 2>/dev/null; echo "0 23 * * * tar -czf /backup/myapp/config-\$(date +\%Y-\%m-\%d).tar.gz -C /opt/myapp config && find /backup/myapp -name 'config-*.tar.gz' -mtime +7 -delete") | crontab -
  345  ls -ld /opt/myapp /opt/myapp/*
  346  getfacl /opt/myapp /opt/myapp/logs
  347  lsattr /opt/myapp/config/application.conf
  348  crontab -l
  349  clear
  350  groupadd security; groupadd auditors; groupadd operators; useradd -G security security01; useradd -G auditors auditor01; useradd -G operators operator01; useradd -G security admin01; mkdir -p /security/{confidential,reports,audit,scripts}
  351  chmod 700 /security/confidential; setfacl -m u:admin01:rwx,u:security01:rwx,u:auditor01:rx,u:operator01:--- /security/confidential
  352  chmod 3770 /security/audit; setfacl -d -m g:security:rwx,g:auditors:rx /security/audit
  353  touch /security/confidential/security-policy.txt; chattr +a /security/confidential/security-policy.txt
  354  echo -e '#!/bin/bash\n{\ndate; hostname; ls-ld /security/*; getfacl -R /security; lsattr -R /security\n} >> /var/log/security_check.log' > /usr/local/bin/security_check.sh; chmod +x /usr/local/bin/security_check.sh; (crontab -l 2>/dev/null; echo '0 1 * * * /usr/local/bin/security_check.sh") | crontab -
  355  echo '{ date; hostname; ls -ld /security/*; getfacl -R /security; lsattr -R /security; } >> /var/log/security_check.log' > /usr/local/bin/security_check.sh && chmod +x /usr/local/bin/security_check.sh
  356  (crontab -l 2>/dev/null; echo "0 1 * * * /usr/local/bin/security_check.sh") | crontab - && /usr/local/bin/security_check.sh && tail -n 15 /var/log/security_check.log
  357  mkdir -p ~/linux-security-assignment && cd ~/linux-security-assignment
  358  history | tail -n 60 > solution.sh
