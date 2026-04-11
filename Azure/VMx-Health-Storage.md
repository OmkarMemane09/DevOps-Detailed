# Microsoft Azure — VM Extensions, Resource Health & Storage Notes


## 1. Checking System Reliability & Availability

### Resource Health in Azure Portal

When a VM or any Azure resource experiences issues, the first place to investigate is **Resource Health**, accessible directly from the Azure Portal.

**Navigation Path:**
```
Azure Portal
  → Virtual Machines
    → Select your VM
      → Help (left sidebar)
        → Resource Health
```

### What Resource Health Shows

| Status | Meaning |
|--------|---------|
| **Available** | Resource is running normally, no issues detected |
| **Unavailable** | Resource is down due to Azure platform issues |
| **Degraded** | Resource is running but with reduced performance |
| **Unknown** | Health status cannot be determined (usually transient) |

### Types of Issues Resource Health Distinguishes

**Platform-initiated issues** — Problems caused by Azure infrastructure (hardware failure, data center incident). Microsoft is responsible for resolution.

**User-initiated issues** — Problems caused by actions you took (OS crash after a bad update, misconfigured NSG blocking traffic, application failure). You are responsible for resolution.

### Resource Health vs Service Health vs Azure Monitor

| Tool | Scope | What It Answers |
|------|-------|----------------|
| **Resource Health** | Your specific resource | "Is MY VM healthy right now?" |
| **Service Health** | Azure platform globally | "Is there an Azure outage in my region?" |
| **Azure Monitor** | Custom metrics & logs | "What was my VM's CPU at 3AM yesterday?" |
| **Activity Log** | All operations on a resource | "Who restarted my VM and when?" |

> **Practical workflow:** If your VM is unreachable, check Resource Health first. If it shows "Available" but your app is still down, the problem is within your OS or application — not Azure infrastructure.

---

## 2. MobaXterm — VM Connectivity

### What is MobaXterm?

**MobaXterm** is a Windows-based terminal application that combines SSH, RDP, file transfer (SFTP), and a graphical interface into a single tool. It is widely used by engineers to manage remote Linux and Windows servers.

It is an alternative to the built-in Windows Command Prompt or PowerShell for connecting to cloud VMs.

### Connection Methods Available in MobaXterm

---

#### Method 1 — Key-Based Login (SSH Key Authentication)

The most secure method. Uses a public/private key pair instead of a password.

**How it works:**
```
Your Machine                        Azure VM
+------------------+                +-------------------------+
| Private Key      |  SSH handshake | Public Key stored in    |
| (~/.ssh/id_rsa)  | <----------->  | ~/.ssh/authorized_keys  |
+------------------+                +-------------------------+
     Your side                           VM side
```

**Steps in MobaXterm:**
1. Open MobaXterm → Click **Session** → **SSH**
2. Enter the **Remote Host** (Public IP of your VM)
3. Check **"Use private key"** and browse to your `.pem` file (downloaded from Azure)
4. Enter the **username** (default: `azureuser` for Azure Linux VMs)
5. Click **OK** — connected without any password prompt

**Key formats:**
- Azure provides keys as `.pem` files
- MobaXterm accepts `.pem` directly; no conversion needed

**Advantages:**
- No password to remember or rotate
- Immune to brute-force password attacks
- Industry standard for production servers

---

#### Method 2 — Password-Based Login

Simpler but less secure. Requires a username and password set during VM creation.

**Steps in MobaXterm:**
1. Open MobaXterm → **Session** → **SSH**
2. Enter **Remote Host** (Public IP)
3. Enter **username** and click OK
4. MobaXterm will prompt for the password

**When to use:**
- Quick testing or lab environments
- When key management is not set up
- Not recommended for production VMs

**Risk:** Passwords can be brute-forced if port 22 is open to the internet. Always restrict SSH access via NSG to trusted IPs.

---

#### Method 3 — GUI-Based Login (RDP via MobaXterm)

For **Windows VMs** or Linux VMs with a desktop environment installed (e.g., XFCE, GNOME).

**For Windows VMs (RDP):**
1. Open MobaXterm → **Session** → **RDP**
2. Enter the **Remote Host** (Public IP)
3. Enter **username** and **password**
4. Full Windows desktop opens inside MobaXterm

**For Linux VMs with GUI (X11 forwarding):**
1. Open MobaXterm → **Session** → **SSH**
2. Enable **X11 forwarding** checkbox
3. MobaXterm has a built-in X server — GUI applications from the Linux VM render on your Windows screen

**MobaXterm Advantages over Basic SSH clients:**
- Built-in SFTP file browser (drag and drop files to/from VM)
- Multiple sessions in tabs
- Saves session configurations
- Built-in X11 server for GUI forwarding
- Free for personal use

---

## 3. VM Extensions — Deep Dive

### What are VM Extensions?

VM Extensions are **lightweight software agents** that run inside your VM to perform automation tasks **after deployment** — without requiring you to manually log in.

They are installed and managed by the **Azure VM Agent**, which is pre-installed on all Azure Marketplace VMs.

### The Core Idea

```
Traditional approach:
  Deploy VM → SSH into VM → Manually run commands → Install software

With Extensions:
  Deploy VM → Attach Extension → Software installs automatically
              (No login required. Runs silently in the background.)
```

### How Extensions Execute

```
Azure Portal / ARM Template / CLI / Terraform
          |
          | (sends extension config)
          v
  Azure VM Agent (running inside VM)
          |
          | (downloads and executes extension)
          v
  Extension runs as a background process
          |
          v
  Output / status reported back to Azure Portal
```

### Why "Secretly" / Without Login?

Extensions run as a **system-level background process** (root on Linux, SYSTEM on Windows). They do not need an interactive shell session. This is why extensions enable automation without any human logging in — essential for:

- **Zero-touch deployments** — VMs configure themselves on first boot
- **Infrastructure as Code** — Terraform/ARM templates provision AND configure everything
- **Scale Set automation** — When VMSS adds 50 new VMs, extensions run on all of them automatically

### Common VM Extensions Reference

| Extension Name | OS | What It Does |
|----------------|----|-------------|
| **Custom Script Extension** | Linux & Windows | Runs any shell/PowerShell script on the VM |
| **Azure Monitor Agent** | Linux & Windows | Sends logs and metrics to Azure Monitor / Log Analytics |
| **Microsoft Antimalware** | Windows | Installs Windows Defender and manages antivirus policies |
| **DSC (Desired State Config)** | Windows | Enforces OS configuration compliance |
| **Key Vault Extension** | Linux & Windows | Auto-rotates and injects certificates from Azure Key Vault |
| **Azure AD Login** | Linux & Windows | Allows login using Azure AD credentials instead of local user |
| **Diagnostics Extension** | Linux & Windows | Captures detailed boot diagnostics, crash dumps |
| **NVIDIA GPU Driver** | Linux & Windows | Auto-installs GPU drivers on N-series VMs |
| **Dependency Agent** | Linux & Windows | Maps network connections between VMs for Azure Monitor |

### Custom Script Extension — Practical Example

```bash
#!/bin/bash
# This script runs automatically via Custom Script Extension
# No one logged in — Azure runs this silently on boot

apt-get update -y
apt-get install -y nginx
systemctl start nginx
systemctl enable nginx
echo "<h1>Deployed via Azure VM Extension</h1>" > /var/www/html/index.html
```

This script is stored in Azure Blob Storage or GitHub, referenced in the extension config, and Azure executes it on the VM automatically.

---

## 4. Azure Storage — Core Concepts

### What is Azure Storage?

**Azure Storage** is Microsoft's cloud storage platform offering multiple storage services for different data types and access patterns under a single **Storage Account**.

### AWS to Azure Storage Service Mapping

| AWS Service | Azure Equivalent | Type |
|-------------|-----------------|------|
| **S3 (Simple Storage Service)** | **Azure Blob Storage** | Object storage for unstructured data |
| **EFS (Elastic File System)** | **Azure File Share** | Managed NFS/SMB network file system |
| **SQS (Simple Queue Service)** | **Azure Queue Storage** | Message queuing between services |
| **DynamoDB** | **Azure Table Storage** | NoSQL key-value store |
| **EBS (Elastic Block Store)** | **Azure Managed Disk** | Block storage attached to VMs |

### The Five Azure Storage Services

| Service | Description | Best For |
|---------|-------------|----------|
| **Blob Storage** | Object storage for any file type | Images, videos, backups, logs, big data |
| **File Share** | Fully managed SMB/NFS file share | Shared network drive for multiple VMs |
| **Queue Storage** | Message queue (up to 64 KB per message) | Decoupling application components |
| **Table Storage** | NoSQL key-value/attribute store | Structured non-relational data |
| **Disk Storage** | Block storage volumes for VMs | OS disks, data disks attached to VMs |

---

## 5. Storage Account — Structure & Hierarchy

### What is a Storage Account?

A **Storage Account** is the top-level Azure resource that provides a unique namespace for all your storage data. Every Blob, File Share, Queue, and Table lives inside a Storage Account.

### Hierarchy

```
Azure Subscription
  └── Resource Group
        └── Storage Account  (e.g., mystorageaccount)
              ├── Blob Service
              │     ├── Container  (e.g., images)
              │     │     ├── photo1.jpg
              │     │     ├── photo2.jpg
              │     │     └── backup.zip
              │     └── Container  (e.g., logs)
              │           └── app-log-2024.txt
              ├── File Service
              │     └── File Share  (e.g., shared-drive)
              ├── Queue Service
              │     └── Queue  (e.g., order-queue)
              └── Table Service
                    └── Table  (e.g., usersTable)
```

### Storage Account Naming Rules

- 3 to 24 characters, lowercase letters and numbers only
- Must be globally unique across all of Azure
- No hyphens, underscores, or uppercase allowed

```
Valid:   mystorageaccount123
Invalid: My-Storage_Account  (uppercase + special chars)
```

### Types of Storage Accounts

| Type | Supported Services | Use Case |
|------|--------------------|----------|
| **Standard General Purpose v2** | Blob, File, Queue, Table | Recommended for most scenarios |
| **Premium Block Blobs** | Blob only | Low-latency blob workloads |
| **Premium File Shares** | File Share only | High-performance file shares |
| **Premium Page Blobs** | Page Blobs only | VHD disks for Azure VMs |

---

## 6. Blob Storage — Deep Dive

### What is Blob Storage?

**Blob** stands for **Binary Large Object**. Azure Blob Storage is designed to store **massive amounts of unstructured data** — any file of any format.

### Blob Storage Structure

```
Storage Account
  └── Container  (equivalent to an S3 Bucket)
        └── Blobs (the actual files)
```

**Containers** are the top-level organizers within Blob Storage. There is no true folder hierarchy — the "folder" appearance in the portal is simulated using `/` in blob names (e.g., `logs/2024/january/app.log`).

### Three Types of Blobs

| Blob Type | Description | Best For |
|-----------|-------------|----------|
| **Block Blob** | Stores data as blocks; optimized for streaming | Files, images, videos, documents, backups |
| **Append Blob** | Optimized for append operations only | Log files, audit trails |
| **Page Blob** | Stores 512-byte pages; optimized for random read/write | VHD files for VM disks |

### Blob Storage vs S3

| Feature | Azure Blob | AWS S3 |
|---------|-----------|--------|
| Top-level container | Container | Bucket |
| Max object size | 190.7 TB (Block Blob) | 5 TB per object |
| Max storage | Unlimited | Unlimited |
| Global namespace | Per storage account | Global bucket name |
| Access control | RBAC + SAS tokens + ACLs | IAM + Bucket policies + ACLs |
| Static website hosting | Yes | Yes |
| Versioning | Yes | Yes |
| Lifecycle policies | Yes | Yes |

---

## 7. Root Volume vs Object Storage

### Root Volume (OS Disk / EBS)

The **root volume** (called **OS Disk** in Azure, **Root EBS Volume** in AWS) is the **primary block storage device** attached to a VM where the **operating system is installed**.

```
Virtual Machine
  └── OS Disk (Root Volume)
        ├── /boot        (bootloader)
        ├── /            (root filesystem)
        ├── /etc         (config files)
        ├── /usr         (installed programs)
        └── /var         (logs, databases)
```

### Why S3 / Blob Storage Cannot Be a Root Volume

This is a fundamental cloud architecture concept:

| Property | Block Storage (EBS / Managed Disk) | Object Storage (S3 / Blob) |
|----------|------------------------------------|---------------------------|
| Access method | Direct block-level I/O | HTTP API (REST) |
| Bootable | **Yes** | **No** |
| File system support | Yes (ext4, NTFS, XFS) | No file system |
| Random read/write | Yes (essential for OS) | No (whole object replace) |
| IOPS performance | High (optimized for OS) | Low (not designed for it) |
| Latency | Milliseconds | Higher (network round-trip) |

**Key rule:** An operating system needs to **read and write individual blocks of data** at high speed during boot and runtime. Object storage works by storing and retrieving **entire files over HTTP** — it has no concept of individual disk sectors. This makes it fundamentally incompatible as a boot device.

> S3/Blob is **non-bootable**. You cannot install or run an OS from it.

### The EBS / Managed Disk Constraint

Another important rule learned:

> **You cannot decrease the size of an EBS volume (AWS) or a Managed Disk (Azure) once it has been expanded.**

Disk shrinking is not supported because the filesystem's partition table and data layout would be corrupted. The only way to downsize is to create a new smaller disk, copy the data, and swap.

```
Allowed:   50 GB → 100 GB  (expand)
Not Allowed: 100 GB → 50 GB  (shrink — data loss risk)
```

---

## 8. Azure Storage Tiers vs AWS S3 Storage Classes

This is one of the most important cost-optimization concepts in cloud storage. Both Azure and AWS allow you to move data to cheaper storage as it is accessed less frequently.

### The Core Concept

```
Time since last access:

Frequent ────────────────────────────────────► Rare/Never
   |                                               |
[Hot/Standard] → [Cool/IA] → [Cold] → [Archive/Glacier]
   |                                               |
Expensive                                       Cheapest
Fast retrieval                            Slow / costly retrieval
```

---

### Azure Blob Storage Tiers

#### Hot Tier

- **Purpose:** Frequently accessed data
- **Storage cost:** Highest per GB
- **Access cost:** Lowest per operation
- **Retrieval time:** Immediate (milliseconds)
- **Minimum storage duration:** None
- **Use cases:**
  - Active application data
  - Images and assets on a live website
  - Databases being actively read
  - Files uploaded and downloaded daily

#### Cool Tier

- **Purpose:** Infrequently accessed data, stored for at least 30 days
- **Storage cost:** Lower than Hot (~50% cheaper)
- **Access cost:** Higher per operation than Hot
- **Retrieval time:** Immediate (milliseconds)
- **Minimum storage duration:** 30 days (early deletion fee applies)
- **Use cases:**
  - Short-term backups
  - Older application logs still occasionally reviewed
  - Data accessed once a month or less
  - Disaster recovery copies

#### Cold Tier

- **Purpose:** Rarely accessed data, stored for at least 90 days
- **Storage cost:** Lower than Cool
- **Access cost:** Higher than Cool
- **Retrieval time:** Immediate (milliseconds)
- **Minimum storage duration:** 90 days
- **Use cases:**
  - Long-term backups not frequently needed
  - Data that must be retained for compliance but rarely accessed
  - Older project files kept for reference

#### Archive Tier

- **Purpose:** Data that is almost never accessed, retained for 180+ days
- **Storage cost:** Lowest — up to 90% cheaper than Hot
- **Access cost:** Highest — rehydration fee applies
- **Retrieval time:** Hours (not immediate — requires "rehydration")
- **Minimum storage duration:** 180 days
- **Rehydration priority options:** Standard (up to 15 hours), High (under 1 hour, higher cost)
- **Use cases:**
  - Regulatory compliance archives (7–10 year retention requirements)
  - Raw footage / media archives
  - Old financial records
  - Scientific data that must be kept but rarely viewed

> **Important:** Objects in Archive tier are **offline**. They cannot be read directly. You must first "rehydrate" (move) the blob to Hot or Cool tier before accessing it.

---

### AWS S3 Storage Classes

#### S3 Standard

- Equivalent to Azure **Hot Tier**
- Frequently accessed data
- Immediate retrieval, highest storage cost, lowest access cost
- 99.999999999% (11 nines) durability

#### S3 Standard-IA (Infrequent Access)

- Equivalent to Azure **Cool Tier**
- Data accessed less than once a month
- Same immediate retrieval as Standard
- Lower storage cost, higher per-GB retrieval fee
- Minimum storage: 30 days

#### S3 One Zone-IA

- Like Standard-IA but stored in **only one Availability Zone**
- 20% cheaper than Standard-IA
- Lower durability — data is lost if that AZ fails
- Suitable for re-creatable data (thumbnails, processed data)
- No direct Azure equivalent (Azure redundancy is configured at the storage account level)

#### S3 Glacier Instant Retrieval

- Equivalent to Azure **Cold Tier**
- Archive data that needs millisecond retrieval occasionally
- Cheaper storage than IA, more expensive retrieval
- Minimum storage: 90 days

#### S3 Glacier Flexible Retrieval

- Equivalent to Azure **Archive Tier** (Standard rehydration)
- Low-cost archive storage
- Retrieval time: 1 minute to 12 hours depending on retrieval tier
- Minimum storage: 90 days

#### S3 Glacier Deep Archive

- Cheapest AWS storage option — no direct Azure equivalent (Archive is closest)
- Designed for data accessed once or twice a year
- Retrieval time: 12–48 hours
- Minimum storage: 180 days

#### S3 Intelligent-Tiering

- **Unique to AWS** — automatically moves objects between tiers based on access patterns
- No retrieval fees for objects moved by the service
- Small monthly monitoring fee per object
- Azure equivalent: **Lifecycle Management Policies** (rule-based automation, not ML-driven)

---

### Direct Comparison Table: Azure Tiers vs AWS S3 Classes

| Feature | Azure Hot | Azure Cool | Azure Cold | Azure Archive |
|---------|-----------|------------|------------|---------------|
| **AWS Equivalent** | S3 Standard | S3 Standard-IA | S3 Glacier Instant Retrieval | S3 Glacier Flexible / Deep Archive |
| **Retrieval Speed** | Immediate | Immediate | Immediate | Hours (rehydration required) |
| **Storage Cost** | Highest | Medium | Low | Lowest |
| **Access Cost** | Lowest | Medium | High | Highest |
| **Min. Storage Duration** | None | 30 days | 90 days | 180 days |
| **Best For** | Active data | Monthly access | Quarterly access | Annual / compliance |
| **Early Deletion Fee** | None | Yes (30 days) | Yes (90 days) | Yes (180 days) |

---

### Lifecycle Management — Automating Tier Transitions

Both Azure and AWS allow you to define rules that **automatically move data to cheaper tiers** as it ages.

**Example Azure Lifecycle Policy:**
```
If blob has not been accessed for 30 days  → Move to Cool tier
If blob has not been accessed for 90 days  → Move to Cold tier
If blob has not been accessed for 365 days → Move to Archive tier
If blob is older than 7 years              → Delete
```

**Why this matters:**
- Eliminates manual data management
- Reduces storage costs automatically
- Enforces data retention compliance policies

---

## 9. AWS to Azure Storage — Service Mapping

| AWS Service | Azure Service | Notes |
|-------------|--------------|-------|
| S3 | Azure Blob Storage | Object storage for unstructured data |
| EBS | Azure Managed Disk | Block storage attached to VMs (bootable) |
| EFS | Azure File Share | Managed network file system (SMB/NFS) |
| SQS | Azure Queue Storage | Simple message queuing |
| DynamoDB | Azure Table Storage | NoSQL key-value store (simpler than Cosmos DB) |
| DynamoDB (advanced) | Azure Cosmos DB | Globally distributed NoSQL (full feature parity) |
| S3 Glacier | Azure Archive Tier | Long-term cold archive storage |
| AWS Storage Gateway | Azure StorSimple / Azure File Sync | Hybrid on-premise to cloud storage |
| AWS Backup | Azure Backup | Centralized backup management |
| CloudFront + S3 | Azure CDN + Blob Storage | Content delivery network with object storage origin |

---

## 10. Storage Decision Guide

Use this guide to choose the right storage type:

```
What type of data are you storing?
│
├── Files attached to a VM (OS or data disks)?
│     └── Use: Azure Managed Disk (EBS equivalent)
│
├── Unstructured files (images, videos, documents, backups)?
│     └── Use: Azure Blob Storage (S3 equivalent)
│           │
│           ├── Accessed daily?          → Hot Tier
│           ├── Accessed monthly?        → Cool Tier
│           ├── Accessed quarterly?      → Cold Tier
│           └── Accessed yearly/never?   → Archive Tier
│
├── Shared file system across multiple VMs?
│     └── Use: Azure File Share (EFS equivalent)
│
├── Messages between application components?
│     └── Use: Azure Queue Storage (SQS equivalent)
│
└── Simple structured non-relational data?
      └── Use: Azure Table Storage (DynamoDB basic equivalent)
```

---

## 11. Key Concepts Glossary

| Term | Definition |
|------|-----------|
| **Blob** | Binary Large Object — any file stored in Azure Blob Storage |
| **Container** | Top-level organizer inside Blob Storage (equivalent to S3 bucket) |
| **Storage Account** | Azure resource that holds all storage services under one namespace |
| **Root Volume** | Primary OS disk of a VM — must be block storage, not object storage |
| **Block Storage** | Storage that presents as a disk with addressable blocks (EBS, Managed Disk) |
| **Object Storage** | Storage that handles files as whole objects via HTTP (S3, Blob) — non-bootable |
| **Hot Tier** | Highest cost storage, lowest access cost — for frequently accessed data |
| **Cool Tier** | Lower cost storage, higher access cost — minimum 30 day retention |
| **Cold Tier** | Lower cost than Cool — minimum 90 day retention, immediate retrieval |
| **Archive Tier** | Lowest cost storage — offline, requires rehydration, minimum 180 days |
| **Rehydration** | Process of moving a blob from Archive to Hot/Cool before it can be read |
| **Lifecycle Policy** | Automated rules that move or delete data based on age or last access |
| **SAS Token** | Shared Access Signature — time-limited URL granting access to a blob |
| **MobaXterm** | Windows SSH/RDP terminal with GUI, SFTP, and X11 forwarding support |
| **VM Extension** | Agent that runs scripts/software on a VM without manual login |
| **Resource Health** | Azure portal feature showing the health status of a specific resource |
| **Rehydration Priority** | Speed option when restoring from Archive: Standard (15 hrs) or High (<1 hr) |
| **EBS** | Elastic Block Store — AWS equivalent of Azure Managed Disk |
| **S3 Intelligent-Tiering** | AWS-only feature that auto-moves objects between tiers using access patterns |

---

## Today's Learning Summary

```
- Resource Health path: VM → Help → Resource Health
- MobaXterm supports: Key-based login, Password login, GUI/RDP login
- VM Extensions run silently in background — no login required
- Azure Storage structure: Storage Account → Container → Blobs
- Blob = Binary Large Object = object storage (non-bootable)
- S3/Blob cannot be root volume — they are non-bootable object stores
- EBS volumes cannot be shrunk — only expanded
- Storage tiers (cheapest to most expensive): Archive → Cold → Cool → Hot
- Archive requires rehydration before data can be accessed (takes hours)
- Lifecycle policies automate tier transitions based on age/access
```

---

*Storage costs can be one of the largest cloud bills. Understanding tiers is one of the most valuable skills for any cloud engineer.*
