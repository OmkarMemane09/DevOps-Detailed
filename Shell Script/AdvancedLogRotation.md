# Cron Job + Shell Script for Advanced Log Rotation

## Scenario

A production application continuously generates log files. Over time, these logs consume significant disk space and can fill up the filesystem if they are not managed properly.

### Requirements

- Compress log files older than **7 days**
- Move compressed logs to an archive directory
- Delete archived logs older than **30 days**
- Automate the entire process using a **Cron Job**

---

## Step 1: Create the Shell Script

Create a shell script:

```bash
nano log_rotation.sh
```

Paste the following script:

```bash
#!/bin/bash

# Source and destination directories
LOG_DIR="/var/log/myapp"
ARCHIVE="/backup/logs"

# Create archive directory if it doesn't exist
mkdir -p "$ARCHIVE"

echo "========== Log Rotation Started =========="
echo "Time: $(date)"

# Compress log files older than 7 days
find "$LOG_DIR" -type f -name "*.log" -mtime +7 -exec gzip {} \;

# Move compressed logs to archive
find "$LOG_DIR" -type f -name "*.gz" -exec mv {} "$ARCHIVE" \;

# Delete archived logs older than 30 days
find "$ARCHIVE" -type f -name "*.gz" -mtime +30 -delete

echo "Log Rotation Completed Successfully"
echo "========================================="
```

---

## Step 2: Make the Script Executable

```bash
chmod +x log_rotation.sh
```

---

## Step 3: Test the Script Manually

```bash
./log_rotation.sh
```

Verify that:

- Old log files are compressed.
- Compressed files are moved to the archive directory.
- Archived logs older than 30 days are removed.

---

## Step 4: Configure Cron Job

Open the cron table:

```bash
crontab -e
```

Add the following entry:

```cron
0 2 * * * /home/ubuntu/log_rotation.sh
```

### Cron Format

```
┌──────── Minute (0 - 59)
│ ┌────── Hour (0 - 23)
│ │ ┌──── Day of Month (1 - 31)
│ │ │ ┌── Month (1 - 12)
│ │ │ │ ┌─ Day of Week (0 - 7)
│ │ │ │ │
0 2 * * * /home/ubuntu/log_rotation.sh
```

This cron job executes the script **every day at 2:00 AM**.

---

# How the Script Works

### Step 1

```bash
mkdir -p "$ARCHIVE"
```

Creates the archive directory if it does not already exist.

---

### Step 2

```bash
find "$LOG_DIR" -type f -name "*.log" -mtime +7 -exec gzip {} \;
```

Finds all `.log` files older than **7 days** and compresses them using `gzip`.

Example:

Before

```
app.log
error.log
```

After

```
app.log.gz
error.log.gz
```

---

### Step 3

```bash
find "$LOG_DIR" -type f -name "*.gz" -exec mv {} "$ARCHIVE" \;
```

Moves all compressed log files to the archive directory.

---

### Step 4

```bash
find "$ARCHIVE" -type f -name "*.gz" -mtime +30 -delete
```

Deletes archived log files older than **30 days**.

---

# Production Workflow

```
Application
      │
      ▼
Writes Logs
      │
      ▼
/var/log/myapp
      │
      ▼
Compress Logs (>7 Days)
      │
      ▼
Move to Archive
      │
      ▼
Delete Archive (>30 Days)
```

---

# Real DevOps Use Case

Suppose an application generates **5 GB of logs every day**.

Without log rotation:

- Disk usage increases continuously.
- `/var` eventually reaches 100%.
- Applications fail to write logs.
- Databases and web servers may become unstable.
- Deployments can fail due to insufficient disk space.

With automated log rotation:

- Logs remain organized.
- Older logs are compressed, saving storage.
- Archived logs are retained for compliance.
- Old archives are automatically removed.
- Disk usage remains under control.

---

# Best Practices

- Always test the script manually before scheduling it with Cron.
- Store archives on a separate filesystem if possible.
- Monitor available disk space using `df -h`.
- Maintain backups for critical logs before deletion.
- Redirect Cron output to a log file for auditing.

Example:

```cron
0 2 * * * /home/ubuntu/log_rotation.sh >> /var/log/log_rotation.log 2>&1
```

---

# Common Interview Follow-up Questions

### Why compress logs?

- Reduces disk usage.
- Speeds up backups.
- Simplifies archival.

---

### Why archive logs?

- Compliance and auditing.
- Troubleshooting historical issues.
- Disaster recovery.

---

### Why delete logs after 30 days?

To prevent disk exhaustion while retaining logs for a defined retention period.

---

### Why use Cron?

Cron automates recurring administrative tasks without manual intervention.

---

# Interview Tip

In production environments, most organizations use utilities like **logrotate** for standard log management. However, interviewers often ask you to implement log rotation using a shell script and Cron to assess your understanding of Linux scripting, file management, automation, and scheduling concepts.
