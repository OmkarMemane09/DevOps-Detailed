### Cron Job + Shell Script for Advanced Log Rotation

## Application writes logs continuously.

**Need to:**

- Compress logs
- Archive logs
- Delete logs older than 30 days

  
``
nano log_rotation.sh
``
``
#!/bin/bash

LOG_DIR="/var/log/myapp"
ARCHIVE="/backup/logs"

mkdir -p $ARCHIVE

find $LOG_DIR -name "*.log" -mtime +7 -exec gzip {} \;

find $LOG_DIR -name "*.gz" -exec mv {} $ARCHIVE \;

find $ARCHIVE -name "*.gz" -mtime +30 -delete

``

*Make executable*
``
chmod +x log_rotation.sh
``
*Cron Entry*

**Run every day at 2 AM**
``bash
0 2 * * * /home/ubuntu/log_rotation.sh
``
Production Use

**Prevents**

- Disk full
- Huge log files
- Manual cleanup
