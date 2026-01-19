# Linux Basics 

## 1. What is Linux and why is it preferred in DevOps?
Linux is an open-source operating system widely used in DevOps due to its stability, security, automation support, and compatibility with cloud and container tools.

## 2. Difference between Linux and Unix?
Unix is proprietary, while Linux is open-source and freely available with wide community and enterprise support.

## 3. What is a shell?
A shell is an interface that allows users to interact with the OS using commands (e.g., Bash, Zsh).

## 4. Difference between CLI and GUI?
CLI uses text-based commands, while GUI uses graphical elements like windows and icons.

## 5. Absolute path vs Relative path?
Absolute path starts from root (`/`), while relative path starts from the current directory.

## 6. What does `ls -la` do?
Lists all files including hidden ones with detailed permissions and ownership.

## 7. Difference between `cat`, `less`, and `more`?
`cat` displays entire file, `less` and `more` allow paginated viewing.

## 8. How do you find files in Linux?
Using the `find` command based on name, type, or size.

## 9. What is `grep` used for?
Searches for patterns or text inside files.

## 10. What is input/output redirection?
Redirecting command input or output using `>`, `>>`, `<`.

## 11. What are pipes (`|`)?
Pipes pass output of one command as input to another.

## 12. Difference between `cp`, `mv`, and `rm`?
`cp` copies files, `mv` moves or renames files, `rm` deletes files.

## 13. What do `head` and `tail` do?
Display the first or last lines of a file.

## 14. How do you check current directory?
Using the `pwd` command.

## 15. What is the `history` command?
Shows previously executed commands.

## 16. How do you check disk usage?
Using `df -h` or `du`.

## 17. Difference between `find` and `locate`?
`find` searches real-time, `locate` searches from a database.

## 18. What is a wildcard?
Special characters like `*` and `?` used to match filenames.

## 19. How do you check command documentation?
Using `man` or `--help`.

## 20. What do Ctrl+C, Ctrl+Z, Ctrl+D do?
Ctrl+C stops a process, Ctrl+Z suspends it, Ctrl+D logs out or ends input.

---
# Linux File System & Permissions 

## 1. What is the Linux file system?
It is a hierarchical structure used to organize files and directories starting from the root (`/`).

## 2. What is the root directory?
The top-level directory (`/`) from which all other directories branch.

## 3. Explain `/bin` and `/sbin`.
`/bin` contains essential user commands, `/sbin` contains system administration commands.

## 4. What is `/etc` used for?
Stores system-wide configuration files.

## 5. Purpose of `/var` directory?
Holds variable data like logs, mail, and spool files.

## 6. What is `/home` directory?
Contains personal directories of users.

## 7. Difference between file and directory?
A file stores data, a directory stores references to files and other directories.

## 8. What are Linux file permissions?
Rules that define read, write, and execute access for users.

## 9. Explain `r`, `w`, `x` permissions.
Read (`r`) allows viewing, write (`w`) allows modification, execute (`x`) allows execution.

## 10. What are user, group, and others?
Permission categories that define access for owner, group members, and everyone else.

## 11. What does `chmod` do?
Changes file or directory permissions.

## 12. Difference between numeric and symbolic permissions?
Numeric uses numbers (755), symbolic uses letters (`u+r`, `g-w`).

## 13. What does permission 755 mean?
Owner has full access, group and others have read and execute access.

## 14. What is `chown` used for?
Changes file or directory ownership.

## 15. What is `chgrp`?
Changes the group ownership of a file or directory.

## 16. What is a hidden file?
A file starting with `.` and not shown by default in `ls`.

## 17. What is a symbolic link?
A shortcut pointing to another file or directory.

## 18. Difference between soft link and hard link?
Soft link points to path, hard link points to inode.

## 19. What is inode?
A data structure storing metadata about a file.

## 20. Why permissions are critical in DevOps?
Incorrect permissions can break applications and cause security issues.

---
# Linux Users & Groups 

## 1. What is a user in Linux?
A user is an entity that can log in and perform operations on the system.

## 2. What is a group in Linux?
A group is a collection of users used to manage permissions collectively.

## 3. Why are users and groups important?
They provide security, access control, and isolation in multi-user systems.

## 4. What is the root user?
The superuser with full administrative privileges.

## 5. What is UID?
User ID, a unique number assigned to each user.

## 6. What is GID?
Group ID, a unique number assigned to each group.

## 7. Difference between root and normal user?
Root has unrestricted access; normal users have limited permissions.

## 8. How do you create a user?
Using the `useradd` command.

## 9. How do you delete a user?
Using the `userdel` command.

## 10. How do you create a group?
Using the `groupadd` command.

## 11. How do you add a user to a group?
Using `usermod -aG groupname username`.

## 12. What is `/etc/passwd`?
Stores basic user account information.

## 13. What is `/etc/shadow`?
Stores encrypted user passwords securely.

## 14. What is `/etc/group`?
Stores group information.

## 15. What is sudo?
Allows a permitted user to execute commands as root.

## 16. Difference between `su` and `sudo`?
`su` switches user, `sudo` executes a single command as root.

## 17. What is a system user?
A non-login user used to run system services.

## 18. How do you check logged-in users?
Using `who` or `w`.

## 19. How do you change a user password?
Using the `passwd` command.

## 20. Why is least privilege important?
It reduces security risks by granting only required permissions.

---
# Linux Process & System Management 

## 1. What is a process in Linux?
A process is a running instance of a program.

## 2. What is a PID?
Process ID, a unique number assigned to each process.

## 3. Difference between process and thread?
A process is independent, a thread is a lightweight unit within a process.

## 4. How do you view running processes?
Using `ps`, `top`, or `htop`.

## 5. What does the `ps -ef` command do?
Displays all running processes with full details.

## 6. What is `top` used for?
Real-time monitoring of system processes and resources.

## 7. Difference between `top` and `htop`?
`htop` is more interactive and user-friendly.

## 8. What is a foreground process?
A process that runs directly in the terminal.

## 9. What is a background process?
A process running without blocking the terminal.

## 10. How do you run a process in background?
Using `&` at the end of the command.

## 11. What is `kill` command?
Used to terminate a process using its PID.

## 12. Difference between `kill` and `kill -9`?
`kill` sends SIGTERM, `kill -9` forcefully stops a process.

## 13. What are signals in Linux?
Signals are messages sent to control process behavior.

## 14. What is load average?
Average system load over time.

## 15. How do you check memory usage?
Using `free -h`.

## 16. How do you check CPU usage?
Using `top` or `htop`.

## 17. What is `nice` and `renice`?
Commands to set or change process priority.

## 18. What is `uptime`?
Shows how long the system has been running.

## 19. What is a zombie process?
A terminated process whose entry still exists in process table.

## 20. Why process management is important in DevOps?
To ensure system stability, performance, and service availability.

---
# Linux Networking Basics 

## 1. What is networking in Linux?
It enables communication between systems over a network.

## 2. What is an IP address?
A unique identifier assigned to a device on a network.

## 3. Difference between IPv4 and IPv6?
IPv4 uses 32-bit addresses, IPv6 uses 128-bit addresses.

## 4. What is a port?
A logical endpoint used to identify services.

## 5. What is DNS?
Domain Name System that resolves domain names to IP addresses.

## 6. How do you check network connectivity?
Using `ping`.

## 7. What does `ifconfig` or `ip addr` do?
Displays network interface details.

## 8. Difference between `netstat` and `ss`?
`ss` is faster and modern; `netstat` is legacy.

## 9. What is `curl` used for?
Testing APIs and transferring data over network.

## 10. What is `wget`?
Downloads files from the internet.

## 11. What is a firewall?
Controls incoming and outgoing network traffic.

## 12. What is `iptables`?
A Linux firewall utility for packet filtering.

## 13. What is `ufw`?
User-friendly firewall management tool.

## 14. How do you check open ports?
Using `netstat -tuln` or `ss -tuln`.

## 15. What is localhost?
The local machine address (127.0.0.1).

## 16. What is a subnet?
A smaller network within a larger network.

## 17. What is a gateway?
A device that routes traffic between networks.

## 18. What is TCP and UDP?
TCP is reliable and connection-oriented; UDP is faster but connectionless.

## 19. How do you check DNS resolution?
Using `nslookup` or `dig`.

## 20. Why networking is critical in DevOps?
Applications, cloud services, and containers rely on network communication.

---

# Linux Shell Scripting 

## 1. What is a shell script?
A shell script is a file containing a sequence of Linux commands executed automatically.

## 2. Why is shell scripting important in DevOps?
It enables automation of repetitive tasks, deployments, monitoring, and maintenance.

## 3. What is a shebang?
`#!/bin/bash` specifies the interpreter to execute the script.

## 4. How do you make a script executable?
Using `chmod +x script.sh`.

## 5. How do you run a shell script?
Using `./script.sh` or `bash script.sh`.

## 6. What are variables in shell scripting?
Variables store data and are accessed using `$variable_name`.

## 7. Difference between local and environment variables?
Local variables are script-specific; environment variables are available system-wide.

## 8. How do you take user input in a script?
Using the `read` command.

## 9. What are positional parameters?
Arguments passed to scripts accessed as `$1`, `$2`, etc.

## 10. What is an if-else statement?
A conditional block used for decision making.

## 11. What are loops in shell scripting?
Used to repeat tasks (`for`, `while`, `until`).

## 12. What is a function in shell scripting?
A reusable block of code that performs a specific task.

## 13. What is exit status?
A value returned by a command indicating success (`0`) or failure (non-zero).

## 14. What is `$?`?
Stores the exit status of the last executed command.

## 15. What is cron?
A job scheduler used to run scripts at scheduled times.

## 16. How do you schedule a cron job?
Using `crontab -e`.

## 17. What is stdout and stderr?
Standard output and standard error streams.

## 18. What is redirection in scripts?
Redirecting output or input using `>`, `>>`, `<`, `2>`.

## 19. What is `set -e`?
Stops script execution if any command fails.

## 20. Give a real DevOps use case of shell scripting.
Automating backups, log cleanup, deployments, and health checks.

---
# Linux Logs & Troubleshooting 

## 1. What are logs in Linux?
Logs are records of system and application events used for monitoring and troubleshooting.

## 2. Where are logs stored in Linux?
Mostly under the `/var/log` directory.

## 3. What is `/var/log/syslog`?
Contains general system activity logs.

## 4. What is `/var/log/messages`?
Stores system messages related to services and kernel events.

## 5. What is `journalctl`?
A command to view logs managed by systemd.

## 6. How do you view recent logs?
Using `tail -f logfile` or `journalctl -xe`.

## 7. What does `journalctl -u service` do?
Shows logs for a specific service.

## 8. What is log rotation?
The process of archiving and deleting old logs to save disk space.

## 9. What tool manages log rotation?
`logrotate`.

## 10. How do you check why a service failed?
Using `systemctl status service-name` and logs.

## 11. What is `dmesg`?
Displays kernel-related messages.

## 12. How do you troubleshoot high disk usage?
Check logs, use `du`, `df`, and identify large files.

## 13. How do you troubleshoot a service not starting?
Check logs, permissions, ports, and dependencies.

## 14. What does `tail -f` do?
Continuously monitors a log file in real time.

## 15. How do you search logs for errors?
Using `grep "error"` on log files.

## 16. What is a common cause of application failure?
Permission issues, port conflicts, or missing dependencies.

## 17. How do you debug a crashed process?
Check logs, core dumps, and system resources.

## 18. What is stderr?
Standard error stream where error messages are written.

## 19. Why logs are critical in DevOps?
They help detect issues, debug failures, and maintain system reliability.

## 20. What is the first step in troubleshooting?
Check logs before making any changes.

---
# Linux Services & Daemons (systemd) 

## 1. What is a service in Linux?
A service is a background process that performs a specific system or application task.

## 2. What is a daemon?
A daemon is a service that runs continuously in the background.

## 3. What is systemd?
systemd is the init system used to manage services and system startup.

## 4. What is `systemctl`?
A command used to control and manage systemd services.

## 5. How do you start a service?
Using `systemctl start service-name`.

## 6. How do you stop a service?
Using `systemctl stop service-name`.

## 7. How do you restart a service?
Using `systemctl restart service-name`.

## 8. How do you check service status?
Using `systemctl status service-name`.

## 9. How do you enable a service at boot?
Using `systemctl enable service-name`.

## 10. How do you disable a service?
Using `systemctl disable service-name`.

## 11. What is the difference between start and enable?
Start runs the service now; enable starts it on boot.

## 12. What is a unit file?
A configuration file that defines how a service is managed by systemd.

## 13. Where are systemd unit files located?
`/etc/systemd/system` and `/lib/systemd/system`.

## 14. What is a target in systemd?
A group of services representing a system state.

## 15. What is the default target?
Usually `multi-user.target` or `graphical.target`.

## 16. How do you reload systemd after changes?
Using `systemctl daemon-reload`.

## 17. How do you list all services?
Using `systemctl list-units --type=service`.

## 18. How do you troubleshoot a failed service?
Check status, logs, permissions, ports, and dependencies.

## 19. What is a masked service?
A service that is completely disabled and cannot be started.

## 20. Why services management is critical in DevOps?
Applications depend on services for availability, automation, and uptime.

---

# Linux Package Management 

## 1. What is package management?
It is the process of installing, updating, upgrading, and removing software on Linux systems.

## 2. What is a package?
A packaged bundle of software, dependencies, and metadata.

## 3. What is a package manager?
A tool that automates software management (e.g., apt, yum, dnf).

## 4. What is `apt`?
A package manager used in Debian-based systems like Ubuntu.

## 5. What is `yum`?
A package manager used in RHEL/CentOS systems.

## 6. What is `dnf`?
The modern replacement for `yum` with better performance and dependency handling.

## 7. How do you install a package using apt?
Using `apt install package-name`.

## 8. How do you remove a package?
Using `apt remove` or `yum remove`.

## 9. Difference between `remove` and `purge`?
`remove` deletes the package, `purge` deletes package and config files.

## 10. How do you update package lists?
Using `apt update`.

## 11. How do you upgrade installed packages?
Using `apt upgrade`.

## 12. What is a repository?
A remote server that stores software packages.

## 13. Where are repository configs stored?
`/etc/apt/sources.list` or `/etc/yum.repos.d/`.

## 14. What is dependency resolution?
Automatically installing required libraries for a package.

## 15. How do you search for a package?
Using `apt search` or `yum search`.

## 16. How do you check installed packages?
Using `dpkg -l` or `rpm -qa`.

## 17. What is RPM?
A package format used by RedHat-based systems.

## 18. What is dpkg?
Low-level Debian package management tool.

## 19. Why package management is important in DevOps?
Ensures consistent environments and automated deployments.

## 20. Common package-related issue in production?
Dependency conflicts or outdated repositories.

---
# Linux Archiving & Backup 

## 1. What is archiving in Linux?
Archiving combines multiple files into a single file for storage or transfer.

## 2. What is backup?
Backup is creating a copy of data to restore in case of failure or loss.

## 3. Difference between archive and backup?
Archive groups files; backup ensures data recovery.

## 4. What is `tar`?
A utility to create and extract archive files.

## 5. How do you create a tar archive?
Using `tar -cvf archive.tar files`.

## 6. How do you extract a tar archive?
Using `tar -xvf archive.tar`.

## 7. What is gzip?
A compression tool used to reduce file size.

## 8. Difference between `.tar` and `.tar.gz`?
`.tar` is archived only; `.tar.gz` is archived and compressed.

## 9. What does `tar -czvf` do?
Creates a compressed tar archive.

## 10. How do you extract `.tar.gz`?
Using `tar -xzvf file.tar.gz`.

## 11. What is zip?
A compression and archiving tool.

## 12. How do you create a zip file?
Using `zip archive.zip files`.

## 13. How do you extract a zip file?
Using `unzip archive.zip`.

## 14. What is rsync?
A tool for efficient file synchronization and backups.

## 15. Why is rsync preferred for backups?
It transfers only changed files, saving time and bandwidth.

## 16. What is incremental backup?
Backs up only data changed since the last backup.

## 17. What is full backup?
Backs up all data every time.

## 18. How do you automate backups?
Using shell scripts and cron jobs.

## 19. What is a common backup mistake?
Not testing backups for restoration.

## 20. Why backup is critical in DevOps?
It ensures data recovery and business continuity.

---

# Linux Environment Variables & Configs 

## 1. What are environment variables?
Key-value pairs used to configure application and system behavior.

## 2. Why are environment variables important?
They allow configuration without changing application code.

## 3. How do you view environment variables?
Using `printenv` or `env`.

## 4. How do you view a specific variable?
Using `echo $VARIABLE_NAME`.

## 5. How do you set an environment variable temporarily?
Using `export VAR=value`.

## 6. How do you unset an environment variable?
Using `unset VAR`.

## 7. Difference between local and environment variables?
Local variables are shell-specific; environment variables are inherited by child processes.

## 8. What is PATH variable?
Defines directories where executables are searched.

## 9. Where are environment variables stored permanently?
In `.bashrc`, `.bash_profile`, `.profile`, or `/etc/environment`.

## 10. Difference between `.bashrc` and `.bash_profile`?
`.bashrc` runs for interactive shells; `.bash_profile` runs on login.

## 11. What is `/etc/environment`?
System-wide environment variable configuration file.

## 12. How do you make variables available to all users?
Define them in `/etc/environment` or `/etc/profile`.

## 13. What are configuration files?
Files that define application or service settings.

## 14. Where are config files usually stored?
Mostly under `/etc`.

## 15. Why should configs not be hardcoded?
Hardcoding makes apps insecure and hard to maintain.

## 16. How do you manage configs in DevOps?
Using environment variables, config files, and secret managers.

## 17. What is a secret?
Sensitive data like passwords, API keys, or tokens.

## 18. Why should secrets not be stored in code?
It creates serious security risks.

## 19. How are env variables used in Docker?
Passed using `-e` flag or `.env` files.

## 20. Why env variables are critical in DevOps?
They enable secure, flexible, and environment-specific deployments.

---
# Linux Real-World Troubleshooting Scenarios 

## 1. A service is down. What is your first step?
Check `systemctl status service-name` and then logs.

## 2. Application is running but not accessible on browser.
Check service status, port listening, firewall, and network connectivity.

## 3. Server disk is suddenly full. What do you do?
Use `df -h`, `du -sh`, check logs under `/var/log`.

## 4. High CPU usage on server.
Use `top` or `htop` to identify the process and analyze it.

## 5. High memory usage causing app crash.
Check `free -h`, process memory usage, and logs.

## 6. Service fails after reboot.
Check if it is enabled using `systemctl enable`.

## 7. Permission denied error in application.
Verify file ownership and permissions using `ls -l`.

## 8. Port already in use error.
Find the process using `ss -tulnp` and stop or change port.

## 9. Application not starting after deployment.
Check logs, config files, environment variables, and permissions.

## 10. User cannot run sudo commands.
Check sudo access in `/etc/sudoers`.

## 11. DNS resolution not working.
Check `/etc/resolv.conf`, test with `nslookup` or `dig`.

## 12. Cron job not running.
Check cron logs, script permissions, and absolute paths.

## 13. Logs growing too fast.
Configure log rotation using `logrotate`.

## 14. Service starts but exits immediately.
Check logs, missing dependencies, and config errors.

## 15. SSH connection refused.
Check SSH service status, firewall, and port 22.

## 16. Environment variable not working in service.
Ensure it is defined in service unit file or system-wide config.

## 17. Deployment works manually but fails in script.
Check PATH, permissions, and non-interactive shell issues.

## 18. File deleted accidentally. What now?
Restore from backup or snapshot.

## 19. System very slow after recent change.
Review recent installs, updates, and logs.

## 20. First rule of Linux troubleshooting?
Never guess — always check logs and system state first.

---

# Linux DevOps  Scenario-Based 

## 1. A web service returns 502 Bad Gateway after deployment. What do you check?
Check the service logs, upstream service status, reverse proxy configuration, and firewall rules.

## 2. Docker container fails to start. How do you troubleshoot?
Check `docker logs`, validate image existence, check ports, environment variables, and dependencies.

## 3. Application is slow after deployment. How do you investigate?
Check CPU/memory usage (`top`), logs for errors, database response times, and network latency.

## 4. Disk is full on the server. How do you find large files?
Use `df -h` to check partitions and `du -sh *` to locate large directories.

## 5. Cron job didn’t execute. How do you debug?
Check cron logs (`/var/log/cron`), file permissions, script path, and environment variables.

## 6. SSH connections fail. What do you check?
Verify SSH service, firewall, port, and user authentication. Check `/var/log/auth.log`.

## 7. Process consumes 100% CPU. How do you handle it?
Identify process via `top/htop`, check its purpose, consider `nice/renice`, and terminate if safe.

## 8. Need to transfer large files efficiently between servers. How?
Use `rsync -avz` or `scp` with compression enabled.

## 9. Application cannot connect to database. What’s your first step?
Check database service status, network connectivity, credentials, and firewall rules.

## 10. Logs show repeated permission denied errors. How to fix?
Audit file ownership/permissions, check SELinux/AppArmor, and user group membership.

## 11. Service works manually but fails with systemd. Why?
Check systemd unit environment, working directory, permissions, and dependency order.

## 12. Config change breaks service. How to revert?
Restore previous config backup, reload service (`systemctl daemon-reload`), and restart.

## 13. Multiple users report slow performance. How to diagnose?
Check CPU, memory, I/O usage, processes, and network throughput.

## 14. Deployment breaks the system. How to rollback?
Use previous application release, restore database snapshot, and verify service status.

## 15. Environment variables not recognized in scripts. Why?
Check if `export` was used, script is sourced, or shell is non-interactive.

## 16. Users cannot access directories. What to do?
Check directory ownership, permissions, ACLs, and group memberships.

## 17. Network interface doesn’t come up. How to debug?
Check `ifconfig/ip addr`, logs (`dmesg`), driver modules, and `/etc/network/interfaces`.

## 18. High memory usage crashes app. How to investigate?
Check `free -h`, `top`, application logs, and potential memory leaks.

## 19. Port is already in use. How do you find the process?
Use `ss -tulnp` or `lsof -i :port` and terminate or change port.

## 20. Application logs grow too fast. What is the solution?
Configure `logrotate` with rotation and compression policies.
# Linux DevOps – Real-Time Scenario-Based Questions & Answers (21-50)

## 21. Server load is high, but no single process is obvious. What do you do?
Check `top` for zombie processes, I/O wait (`iostat`), and memory usage. Investigate background jobs and cron tasks.

## 22. Database backup failed overnight. How do you troubleshoot?
Check cron logs, backup script logs, disk space, permissions, and database connectivity.

## 23. A service randomly crashes. How do you find the cause?
Check logs (`journalctl`), memory dumps, system resources, recent config changes, and dependent services.

## 24. After an update, application dependencies break. How to fix?
Check package versions, rollback update if necessary, reinstall dependencies, and validate environment variables.

## 25. Users report intermittent network failures. What steps do you take?
Ping tests, check routing tables, inspect network interface status, firewall rules, and DNS resolution.

## 26. File disappeared from server. How do you recover?
Check trash or backup, use `find` to locate, restore from `rsync` or snapshot.

## 27. Service won’t start due to missing dependency. How do you resolve?
Check service logs, identify missing dependency, install or start it, and restart the service.

## 28. Application fails with “Out of memory”. What’s your action?
Check memory usage (`free -h`), adjust limits, optimize application, or add swap.

## 29. Permission errors while running scripts as root. How to debug?
Check SELinux/AppArmor status, script ownership, and shebang correctness.

## 30. Cannot resolve domain names. How to fix?
Check `/etc/resolv.conf`, test with `nslookup/dig`, verify DNS server availability.

## 31. Logs show repeated authentication failures. What do you do?
Check `/var/log/auth.log`, verify user accounts, disable suspicious IPs, and enforce stronger passwords.

## 32. Cron job runs but script fails silently. Why?
Check absolute paths, permissions, environment variables, and redirect output to a log.

## 33. A process is stuck in D state. What is it and how to handle?
It’s uninterruptible sleep (usually I/O). Investigate the I/O subsystem and consider reboot if necessary.

## 34. Application cannot bind to port. How do you resolve?
Check if port is in use (`ss -tulnp`), verify permissions (<1024 requires root), or change port.

## 35. You need to monitor server in real-time. Which tools?
`top`, `htop`, `iotop`, `netstat/ss`, `vmstat`, `dstat`, `journalctl -f`.

## 36. File permissions need temporary escalation for a script. How?
Use `sudo`, adjust ACLs temporarily, or run script as root.

## 37. Disk I/O is slow. How to identify cause?
Use `iostat`, `iotop`, check for heavy log writes, backup processes, or unoptimized databases.

## 38. Application environment variable changes not applied. Why?
Check if service was restarted, variable exported properly, and shell type.

## 39. User cannot login via SSH. How to debug?
Check `/etc/ssh/sshd_config`, firewall rules, user account status, and `auth.log`.

## 40. Application hangs during startup. What steps?
Check logs, permissions, missing dependencies, database connectivity, and system resources.

## 41. Server crashes intermittently. How do you investigate?
Check kernel logs (`dmesg`), hardware status, memory errors, CPU temperature, and recent changes.

## 42. You need to synchronize files between two servers daily. How?
Use `rsync` with cron, or a configuration management tool like Ansible.

## 43. Service fails after reboot. What could be wrong?
Service not enabled (`systemctl enable`), dependency missing, or incorrect systemd unit configuration.

## 44. Application logs huge amount of debug info in production. Solution?
Adjust log level, configure log rotation, or redirect debug logs to separate files.

## 45. Database connection times out intermittently. How to troubleshoot?
Check network, firewall, database performance, connection limits, and DNS resolution.

## 46. Multiple applications compete for resources. How to manage?
Use `nice/renice` for CPU, `ulimit` for processes/files, or cgroups for resource control.

## 47. Service stuck in failed state. How do you recover?
Check logs (`journalctl -u service`), restart service, fix underlying cause, then verify.

## 48. Application fails only in non-interactive shell. Why?
Environment variables missing, PATH differences, or shell-specific scripts.

## 49. User reports slow file access on NFS mount. How to debug?
Check network latency, NFS server status, mount options, and caching.

## 50. You need to automate system health checks. How?
Write shell scripts to check CPU, memory, disk, services, and logs; schedule via cron and notify via email/slack.

---
# Linux Troubleshooting Scenarios – DevOps Interview Q&A

## 1. A Linux server is slow — how do you start troubleshooting?
Check CPU, memory, disk I/O, running processes (`top`, `htop`, `iotop`), and system logs.

## 2. CPU is 100% — how do you identify the root cause?
Use `top` or `htop` to find the process, analyze its resource usage, and check logs for abnormal behavior.

## 3. Memory is full — what steps will you take?
Check `free -h`, running processes, memory leaks, swap usage, and optimize or restart heavy processes.

## 4. Disk is 100% — how do you free space safely?
Use `df -h` and `du -sh *` to locate large files, remove unnecessary files, clear logs, and check old backups.

## 5. A service is down — how do you bring it back online?
Check status with `systemctl status service`, review logs, start with `systemctl start service`, and enable if needed.

## 6. SSH is not working — how do you troubleshoot?
Check SSH service, firewall rules, port configuration, `/etc/ssh/sshd_config`, and authentication logs.

## 7. A process is stuck — how do you kill it?
Use `ps` or `top` to find PID, then `kill PID` or `kill -9 PID` if necessary.

## 8. Logs are not getting generated — what do you check?
Verify logging configuration, permissions of log directories, disk space, and service status.

## 9. A user cannot login — how do you fix it?
Check account status (`passwd -S`), shell configuration, `/etc/passwd`, group memberships, and PAM settings.

## 10. Application is not starting after reboot — what do you do?
Ensure the service is enabled (`systemctl enable`), check dependencies, review logs, and validate configuration files.

## 11. How do you find which process is using a port?
Use `ss -tulnp` or `lsof -i :port_number`.

## 12. How do you troubleshoot network issues in Linux?
Ping test, check IP configuration (`ip addr`), routes (`ip route`), DNS resolution (`dig/nslookup`), and firewall rules.

## 13. Files got deleted — how do you recover them?
Restore from backup, snapshots, or recovery tools like `extundelete` if filesystem supports it.

## 14. Server rebooted automatically — how do you find the reason?
Check `journalctl -b -1`, `/var/log/messages`, `dmesg`, and uptime logs.

## 15. High I/O wait — how do you troubleshoot?
Use `iostat` and `iotop` to find heavy processes, check disks, mounts, and optimize I/O-heavy applications.

## 16. A cron job is not running — what do you check?
Check cron logs, script permissions, absolute paths, and environment variables.

## 17. Root filesystem is full — what is your action plan?
Clean old logs, remove unnecessary files, check backups, and expand disk or partitions if needed.

## 18. A service keeps crashing — how do you debug?
Check service logs, dependencies, recent configuration changes, resource limits, and system logs.

## 19. Logs are filling disk — how do you control it?
Configure `logrotate`, compress old logs, and adjust application log levels.

## 20. A process is consuming too much memory — what do you do?
Analyze process behavior, restart or kill it if safe, optimize the application, or allocate more memory.

## 21. How do you find recently modified files?
Use `find /path -type f -mtime -N` or `ls -ltr` to track changes.

## 22. A server got compromised — what are your first steps?
Isolate the server, check logs for intrusion, disable user accounts, and assess damage before restoring.

## 23. How do you safely restart a production server?
Notify users, stop services gracefully, backup critical data, then reboot using `shutdown -r`.

## 24. How do you trace application startup failure?
Check logs, dependencies, config files, environment variables, and required ports.

## 25. How do you identify kernel-related issues?
Check `dmesg`, `/var/log/kern.log`, system crashes, and kernel updates or patches.

## 26. How do you troubleshoot DNS problems on Linux?
Verify `/etc/resolv.conf`, test with `dig`/`nslookup`, check firewall and network connectivity.

## 27. How do you handle a server that won’t boot?
Check BIOS/boot logs, rescue mode, initramfs errors, and filesystem integrity.

## 28. How do you investigate random server crashes?
Analyze `dmesg`, logs, hardware health, recent changes, and core dumps.

## 29. How do you validate system health after recovery?
Check CPU, memory, disk usage, services status, logs, and network connectivity.

## 30. How do you prepare a Linux server for production?
Update packages, configure users and permissions, secure SSH, install monitoring, enable backups, and harden firewall.
