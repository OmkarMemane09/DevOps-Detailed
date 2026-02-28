# Jenkins - Day 2: Installation & Setup on AWS EC2

##  Step 1: Launch AWS EC2 Instance

### 1.1 Create EC2 Instance

```bash
# Login to AWS Console
# Navigate to EC2 Dashboard
# Click "Launch Instance"
```

### 1.2 Configure Instance

| Setting | Value |
|---------|-------|
| **Name** | jenkins-server |
| **AMI** | Ubuntu Server 22.04 LTS |
| **Instance Type** | t2.medium |
| **Key Pair** | Create new or select existing |
| **Storage** | 20 GB gp3 |
| **Security Group** | Create new (see next step) |

### 1.3 Security Group Configuration

**Inbound Rules:**

| Type | Protocol | Port Range | Source | Description |
|------|----------|------------|--------|-------------|
| SSH | TCP | 22 | Your IP (My IP) | SSH access |
| Custom TCP | TCP | 8080 | 0.0.0.0/0 | Jenkins Web UI |
| Custom TCP | TCP | 8081 | 0.0.0.0/0 | Alternative port (optional) |

> **Security Note**: For production, restrict 8080 to specific IPs or use VPN/Bastion host

### 1.4 Launch Instance

```bash
# Click "Launch Instance"
# Wait for instance state: "Running"
# Note down the Public IPv4 address
```
---

##  Step 2: Connect to EC2 Instance

###  Using AWS Console (EC2 Instance Connect)

```bash
# Alternative method:
# 1. Select your instance in EC2 console
# 2. Click "Connect"
# 3. Choose "EC2 Instance Connect"
# 4. Click "Connect"
```

##  Step 3: Install Java (JDK 17)

> ** Why Java?** Jenkins is built with Java and requires JDK to run

### 3.1 Update System Packages

```bash
# Update package index
sudo apt update

# Output shows packages being updated
```

**What this does:**
- Updates the local package index
- Fetches latest package information from repositories
- Prepares system for new installations

### 3.2 Install OpenJDK 17

```bash
# Install Java Development Kit 17
sudo apt install openjdk-17-jdk -y
```

**Installation time:** ~2-3 minutes

**Flags explained:**
- `sudo`: Run with administrator privileges
- `-y`: Automatically answer "yes" to prompts

### 3.3 Verify Java Installation

```bash
# Check Java version
java -version

# Expected output:
# openjdk version "17.0.x"
# OpenJDK Runtime Environment
# OpenJDK 64-Bit Server VM
```

```bash
# Check Java compiler version
javac -version

# Expected output:
# javac 17.0.x
```

```bash
# Find Java installation path
which java

# Output: /usr/bin/java
```

> ** Checkpoint**: Java should show version 17.x.x

---

##  Step 4: Install Jenkins
**Take Command from Jenkin Offcial Documentation**
### 4.1 Add Jenkins Repository Key

```bash
# Download and add Jenkins GPG key
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key
```

**What this does:**
- Downloads Jenkins official signing key
- Saves it to `/etc/apt/keyrings/` directory
- Ensures package authenticity and security

**File created:** `/etc/apt/keyrings/jenkins-keyring.asc`

### 4.2 Add Jenkins Repository to Sources List

```bash
# Add Jenkins repository to apt sources
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
```

**Breaking down the command:**

| Part | Purpose |
|------|---------|
| `echo "deb [signed-by=...]"` | Creates repository entry |
| `sudo tee` | Writes to file with sudo privileges |
| `/etc/apt/sources.list.d/jenkins.list` | Jenkins repository configuration file |
| `> /dev/null` | Suppresses output to terminal |

### 4.3 Update Package Index Again

```bash
# Update package list with Jenkins repository
sudo apt update
```

**Expected output:**
```
Hit:1 https://pkg.jenkins.io/debian-stable binary/ Packages
Get:2 http://archive.ubuntu.com/ubuntu jammy InRelease
...
```

### 4.4 Install Jenkins

```bash
# Install Jenkins package
sudo apt install jenkins -y
```

**Installation time:** ~3-5 minutes

**What gets installed:**
- Jenkins application
- Systemd service
- Configuration files
- Default user (`jenkins`)

### 4.5 Verify Jenkins Service

```bash
# Check Jenkins service status
sudo systemctl status jenkins
```

**Expected output:**
```
● jenkins.service - Jenkins Continuous Integration Server
     Loaded: loaded (/lib/systemd/system/jenkins.service; enabled; vendor preset: enabled)
     Active: active (running) since [Date/Time]
   Main PID: 12345 (java)
```

**Status indicators:**
- **Active: active (running)** ✅ = Jenkins is running
- **Active: inactive (dead)** ❌ = Jenkins is stopped
- **Active: failed** ❌ = Jenkins failed to start

> ** Checkpoint**: Jenkins service should be active and running

---

##  Step 5: Configure Security Group

### 5.1 Allow Jenkins Port in AWS

```bash
# Go to AWS EC2 Console
# Select your instance
# Click on Security tab
# Click on Security Group
# Edit Inbound Rules
# Add rule: Custom TCP, Port 8080, Source: 0.0.0.0/0
```

### 5.2 Verify Port is Open (from EC2)

```bash
# Check if Jenkins is listening on port 8080
sudo netstat -tulpn | grep 8080

# Expected output:
# tcp6  0  0 :::8080  :::*  LISTEN  12345/java
```

**Alternative command:**
```bash
sudo ss -tulpn | grep 8080
```

---

##  Step 6: Access Jenkins Web Interface

### 6.1 Get Your EC2 Public IP

```bash
# From AWS Console: Copy Public IPv4 address
# OR from terminal:
curl http://checkip.amazonaws.com

# Example output: 54.123.45.67
```

### 6.2 Open Jenkins in Browser

```
Format: http://<EC2-Public-IP>:8080

Example: http://54.123.45.67:8080
```

**What you'll see:**
- **Unlock Jenkins** page
- Path to initial admin password
- Text input box for password

![Jenkins Unlock Screen]
```
┌─────────────────────────────────────────┐
│        Unlock Jenkins                    │
├─────────────────────────────────────────┤
│ To ensure Jenkins is securely set up by │
│ the administrator, a password has been   │
│ written to the log (not visible to users)│
│ and this file on the server:            │
│                                          │
│ /var/lib/jenkins/secrets/initialAdminPassword
│                                          │
│ Please copy the password from either     │
│ location and paste it below.            │
│                                          │
│ Administrator password: [____________]  │
│                        [Continue]        │
└─────────────────────────────────────────┘
```

---

##  Step 7: Unlock Jenkins

### 7.1 Get Initial Admin Password

**Path shown on screen:**
```
/var/lib/jenkins/secrets/initialAdminPassword
```

### 7.2 Retrieve Password from EC2

```bash
# Method 1: Using cat command (recommended)
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

# Example output:
# a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6
```

```bash
# Method 2: Using less (for long output)
sudo less /var/lib/jenkins/secrets/initialAdminPassword
```

```bash
# Method 3: Copy to clipboard (if xclip installed)
sudo cat /var/lib/jenkins/secrets/initialAdminPassword | xclip -selection clipboard
```

### 7.3 Understanding the Password

| Property | Value |
|----------|-------|
| **Format** | 32-character alphanumeric string |
| **Location** | `/var/lib/jenkins/secrets/initialAdminPassword` |
| **Permissions** | Only readable by root/jenkins user |
| **Validity** | One-time use (deleted after first login) |
| **Purpose** | Initial security during setup |

### 7.4 Paste Password in Browser

```
1. Copy the password from terminal
2. Paste in "Administrator password" field
3. Click "Continue"
```

> **Important**: Keep this password secure until setup is complete!

---

##  Step 8: Initial Setup Wizard

### 8.1 Customize Jenkins Page

After unlocking, you'll see two options:

```
┌──────────────────────────────────────────┐
│     Customize Jenkins                     │
├──────────────────────────────────────────┤
│                                           │
│  ┌────────────────────────────────────┐  │
│  │  Install suggested plugins          │  │
│  │  (Recommended for most users)       │  │
│  └────────────────────────────────────┘  │
│                                           │
│  ┌────────────────────────────────────┐  │
│  │  Select plugins to install          │  │
│  │  (For advanced users)               │  │
│  └────────────────────────────────────┘  │
└──────────────────────────────────────────┘
```

**Choose:** **Install suggested plugins** ✅

**What gets installed:**
- Git plugin
- Pipeline plugins
- GitHub plugin
- Gradle plugin
- Maven plugin
- SSH plugins
- Email Extension plugin
- Build Timeout plugin
- Credentials plugin
- Workspace Cleanup plugin
- And ~20 more essential plugins

**Installation time:** 5-10 minutes

### 8.2 Create First Admin User

After plugin installation, you'll see:

```
┌──────────────────────────────────────────┐
│     Create First Admin User              │
├──────────────────────────────────────────┤
│ Username:     [________________]          │
│ Password:     [________________]          │
│ Confirm:      [________________]          │
│ Full name:    [________________]          │
│ Email:        [________________]          │
│                                           │
│         [Save and Continue]               │
│      [Continue as admin] (skip)           │
└──────────────────────────────────────────┘
```

**Fill in details:**

| Field | Example | Notes |
|-------|---------|-------|
| Username | `admin` or `your-name` | Cannot be changed later easily |
| Password | `StrongP@ssw0rd!` | Use strong password |
| Confirm Password | `StrongP@ssw0rd!` | Must match |
| Full Name | `John Doe` | Display name |
| Email | `john@example.com` | For notifications |

> **Tip**: Use a password manager to generate and store credentials

**Click:** **Save and Continue**

> **Alternative**: Click "Continue as admin" to keep using `admin` user (not recommended for production)

### 8.3 Instance Configuration

```
┌──────────────────────────────────────────┐
│     Instance Configuration                │
├──────────────────────────────────────────┤
│ Jenkins URL:                              │
│ [http://54.123.45.67:8080/]              │
│                                           │
│ This URL will be used to create links    │
│ in emails and other notifications.       │
│                                           │
│         [Save and Finish]                 │
└──────────────────────────────────────────┘
```

**Options:**
1. **Keep suggested URL** (with Public IP) - Good for testing
2. **Use domain name** (if you have one) - Better for production
3. **Use Elastic IP** (if configured) - Prevents URL changes

**Example with domain:**
```
http://jenkins.your-domain.com
```

**Click:** **Save and Finish**

### 8.4 Jenkins is Ready!

```
┌──────────────────────────────────────────┐
│         Jenkins is ready!                 │
├──────────────────────────────────────────┤
│                                           │
│            🎉 Success!                    │
│                                           │
│    Your Jenkins installation is complete │
│         and ready to use                  │
│                                           │
│         [Start using Jenkins]             │
└──────────────────────────────────────────┘
```

**Click:** **Start using Jenkins**

---

##  Step 9: Change Jenkins Port (Optional)

> **Why change port?**
> - Avoid conflicts with other services
> - Custom security configuration
> - Multiple Jenkins instances on same server

### 9.1 Navigate to Jenkins Configuration Directory

```bash
# Go to Jenkins system configuration directory
cd /lib/systemd/system

# Alternative location (older systems):
# cd /etc/default
```

### 9.2 Edit Jenkins Service File

```bash
# Open Jenkins service configuration
sudo nano /lib/systemd/system/jenkins.service

# OR using vim:
sudo vim /lib/systemd/system/jenkins.service
```

### 9.3 Find and Modify Port Setting

**Look for this line:**
```bash
Environment="JENKINS_PORT=8080"
```

**Change to desired port (example: 8081):**
```bash
Environment="JENKINS_PORT=8081"
```

**Complete section example:**
```ini
[Service]
Type=notify
User=jenkins
Group=jenkins
ExecStart=/usr/bin/jenkins
Environment="JENKINS_HOME=/var/lib/jenkins"
Environment="JENKINS_PORT=8081"          # ← Changed from 8080
Environment="JENKINS_OPTS=--httpPort=8081"  # ← Changed from 8080
```

### 9.4 Alternative Method (Using /etc/default/jenkins)

```bash
# Edit Jenkins defaults file
sudo nano /etc/default/jenkins
```

**Find and modify:**
```bash
# Original
HTTP_PORT=8080

# Change to
HTTP_PORT=8081
```

### 9.5 Save Changes

**For nano:**
```
Press: Ctrl + O (Write Out)
Press: Enter (Confirm)
Press: Ctrl + X (Exit)
```

**For vim:**
```
Press: Esc
Type: :wq
Press: Enter
```

### 9.6 Reload Systemd Daemon

```bash
# Reload systemd manager configuration
sudo systemctl daemon-reload
```

**What this does:**
- Reloads all unit files
- Recognizes changes made to service files
- Required after editing systemd service files

### 9.7 Restart Jenkins Service

```bash
# Restart Jenkins to apply changes
sudo systemctl restart jenkins
```

**Wait ~30 seconds** for Jenkins to fully restart

### 9.8 Verify New Port

```bash
# Check if Jenkins is running on new port
sudo netstat -tulpn | grep jenkins

# Expected output:
# tcp6  0  0 :::8081  :::*  LISTEN  12345/java
```

```bash
# Check service status
sudo systemctl status jenkins

# Should show: Active: active (running)
```

### 9.9 Update AWS Security Group

```bash
# Go to AWS EC2 Console
# Select Security Group
# Edit Inbound Rules
# Add new rule:
#   - Type: Custom TCP
#   - Port: 8081
#   - Source: 0.0.0.0/0
```

### 9.10 Access Jenkins on New Port

```
New URL: http://54.123.45.67:8081

# Old URL will no longer work:
# http://54.123.45.67:8080 
```

> **Success**: Jenkins is now running on port 8081!

---

## Troubleshooting

### Problem 1: Cannot Access Jenkins Web UI

**Symptoms:**
- Browser shows "This site can't be reached"
- Connection timeout error

**Solutions:**

```bash
# 1. Check if Jenkins is running
sudo systemctl status jenkins

# If not running, start it:
sudo systemctl start jenkins

# 2. Verify port is listening
sudo netstat -tulpn | grep 8080

# 3. Check firewall rules (UFW)
sudo ufw status

# If UFW is active, allow Jenkins port:
sudo ufw allow 8080/tcp
sudo ufw reload

# 4. Check AWS Security Group
# Ensure port 8080 is open in inbound rules

# 5. Test from EC2 instance itself
curl http://localhost:8080
# Should return HTML content
```

### Problem 2: Jenkins Service Won't Start

**Symptoms:**
- Service status shows "failed"
- Error in systemctl status

**Solutions:**

```bash
# 1. Check Jenkins logs
sudo journalctl -u jenkins -n 50

# 2. Check Java installation
java -version

# 3. Check disk space
df -h

# 4. Check permissions
ls -la /var/lib/jenkins

# 5. Reset Jenkins service
sudo systemctl stop jenkins
sudo systemctl start jenkins
```

### Problem 3: Forgot Admin Password

**Solution:**

```bash
# Option 1: Reset via initial password (if first time)
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

# Option 2: Disable security temporarily
sudo nano /var/lib/jenkins/config.xml

# Find and change:
<useSecurity>true</useSecurity>
# to:
<useSecurity>false</useSecurity>

# Restart Jenkins:
sudo systemctl restart jenkins

# Access Jenkins without password, then:
# Manage Jenkins → Configure Global Security → Enable security
```

### Problem 4: Port Change Not Working

**Solutions:**

```bash
# 1. Verify changes in service file
sudo cat /lib/systemd/system/jenkins.service | grep PORT

# 2. Ensure daemon reload was executed
sudo systemctl daemon-reload

# 3. Restart Jenkins
sudo systemctl restart jenkins

# 4. Check if old port still bound
sudo lsof -i :8080

# If process found, kill it:
sudo kill -9 <PID>

# 5. Verify new port
sudo netstat -tulpn | grep <new-port>
```

### Problem 5: "Permission Denied" Errors

**Solution:**

```bash
# Check jenkins user permissions
sudo ls -la /var/lib/jenkins

# Fix ownership if needed
sudo chown -R jenkins:jenkins /var/lib/jenkins

# Check jenkins home directory
echo $JENKINS_HOME

# Restart service
sudo systemctl restart jenkins
```

---

## Important File Locations

### Configuration Files

| Path | Purpose |
|------|---------|
| `/var/lib/jenkins/` | Jenkins home directory (JENKINS_HOME) |
| `/var/lib/jenkins/config.xml` | Main Jenkins configuration |
| `/var/lib/jenkins/secrets/initialAdminPassword` | Initial unlock password |
| `/lib/systemd/system/jenkins.service` | Jenkins service configuration |
| `/etc/default/jenkins` | Jenkins default settings (alternative) |
| `/var/lib/jenkins/jobs/` | All Jenkins jobs |
| `/var/lib/jenkins/plugins/` | Installed plugins |
| `/var/lib/jenkins/workspace/` | Build workspaces |
| `/var/lib/jenkins/users/` | User configurations |

### Log Files

| Path | Purpose |
|------|---------|
| `/var/log/jenkins/jenkins.log` | Main Jenkins log |
| `sudo journalctl -u jenkins` | Systemd service logs |
| `/var/lib/jenkins/logs/` | Additional logs |

### Binary & Scripts

| Path | Purpose |
|------|---------|
| `/usr/bin/jenkins` | Jenkins executable |
| `/usr/share/jenkins/` | Jenkins WAR file location |

---

##  Common Jenkins Commands
### Service Management

```bash
# Start Jenkins
sudo systemctl start jenkins

# Stop Jenkins
sudo systemctl stop jenkins

# Restart Jenkins
sudo systemctl restart jenkins

# Check status
sudo systemctl status jenkins

# Enable on boot
sudo systemctl enable jenkins

# Disable on boot
sudo systemctl disable jenkins

# Reload configuration
sudo systemctl daemon-reload
```

### Logs & Monitoring

```bash
# View real-time logs
sudo journalctl -u jenkins -f

# View last 50 log entries
sudo journalctl -u jenkins -n 50

# View logs since boot
sudo journalctl -u jenkins -b

# View Jenkins log file
sudo tail -f /var/log/jenkins/jenkins.log

# Check disk usage
df -h /var/lib/jenkins

# Check Jenkins process
ps aux | grep jenkins

# Check port usage
sudo netstat -tulpn | grep 8080
sudo lsof -i :8080
```

### File Operations

```bash
# Navigate to Jenkins home
cd /var/lib/jenkins

# List all jobs
ls -la /var/lib/jenkins/jobs/

# Backup Jenkins home
sudo tar -czf jenkins-backup-$(date +%Y%m%d).tar.gz /var/lib/jenkins/

# Check Jenkins version
sudo cat /var/lib/jenkins/config.xml | grep version

# View installed plugins
ls -la /var/lib/jenkins/plugins/

# Check Jenkins user
id jenkins
```

### System Information

```bash
# Check Java version
java -version

# Check system resources
free -h
htop  # (if installed)

# Check disk space
df -h

# Check memory usage
cat /proc/meminfo

# Check CPU info
lscpu
```
---
