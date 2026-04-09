# ☁️ Microsoft Azure — Virtual Machines & Core Infrastructure Notes


## 1. Azure Regions & Availability Zones

### 🌍 What is an Azure Region?

An **Azure Region** is a specific **geographic location** around the world where Microsoft has built data centers. Each region is a cluster of data centers connected through a dedicated low-latency network.

> 💡 Azure has **60+ regions** across the globe — more than any other cloud provider.

---

### 🏢 What is an Availability Zone (AZ)?

An **Availability Zone** is a **physically separate data center** within a single Azure Region. Each zone has:
- Its own **power supply**
- Its own **cooling system**
- Its own **networking**

This separation ensures that if one zone goes down (power failure, fire, hardware failure), the other zones remain unaffected.

```
Azure Region: Central India (Pune)
┌─────────────────────────────────────────┐
│  Zone 1       Zone 2       Zone 3       │
│  ┌───────┐   ┌───────┐   ┌───────┐     │
│  │ DC-A  │   │ DC-B  │   │ DC-C  │     │
│  │       │   │       │   │       │     │
│  └───────┘   └───────┘   └───────┘     │
│     ↕ Low-latency fiber connection ↕   │
└─────────────────────────────────────────┘
```

> ⚠️ **Not every Azure Region has Availability Zones!**

---

### 🇮🇳 Indian Azure Regions — Relevant for Indian Learners

| Region Name | Location | Availability Zones | Notes |
|-------------|----------|--------------------|-------|
| **Central India** | Pune | ✅ **3 AZs** | Best for Indian workloads — High availability |
| **West India** | Mumbai | ❌ No AZs | Good location, but no zone redundancy |
| **South India** | Chennai | ❌ No AZs | Available but limited services |

### Why This Matters:
- **Central India (Pune)** → Best choice for **production workloads** needing high availability
- **West India (Mumbai)** → Closer to users in western India but **no fault isolation between zones**
- **South India (Chennai)** → Useful for certain regional compliance needs

### 🌐 Latency Rule of Thumb:
> **Always choose the region closest to your end users** for lowest latency (response time).

For Indian developers & businesses:
```
User in Mumbai    → West India (Mumbai) → ~5ms latency
User in Pune      → Central India (Pune) → ~5ms latency
User in Chennai   → South India (Chennai) → ~5ms latency
Global App        → Central India (AZs available) → Best reliability
```

---

## 2. Azure Health Checks

### 🩺 What are Azure Health Checks?

Azure **Health Checks** are monitoring mechanisms that continuously verify whether your resources (especially VMs and web apps) are **alive, reachable, and responding correctly**.

### Types of Azure Health Monitoring:

| Type | Purpose |
|------|---------|
| **Azure Service Health** | Shows status of Azure platform itself (outages, maintenance) |
| **Azure Resource Health** | Shows health of YOUR specific resource (VM, DB, etc.) |
| **Azure Monitor** | Custom metrics, logs, and alerts for your resources |
| **Application Health Extension** | Checks if the application inside the VM is running |
| **Load Balancer Health Probe** | Probes backend VMs to check if they can serve traffic |

### How Health Probes Work (for VMs behind a Load Balancer):

```
Internet
    ↓
Load Balancer
    ↓ sends health probe every 5 seconds (HTTP/TCP)
   ┌────────────┬────────────┐
   │   VM-1     │   VM-2     │
   │ ✅ Healthy │ ❌ Down    │
   └────────────┴────────────┘
         ↓
   Traffic only sent to VM-1
```

> If a VM fails the health probe, the Load Balancer **stops sending traffic** to it automatically.

### Azure Service Health Portal:
- URL: **[status.azure.com](https://status.azure.com)**
- Shows real-time Azure global outages and incidents

---

## 3. Virtual Machines (VMs) in Azure

### 🖥️ What is a Virtual Machine?

A **Virtual Machine (VM)** is a **software-based computer** that runs on physical hardware inside Azure's data centers. It behaves exactly like a physical server — you get full control over:

- **Operating System** (Windows or Linux)
- **Software & Applications** installed
- **Network configuration** (IP, firewall rules)
- **Storage** (OS disk + data disks)

### AWS Equivalent:
| Azure | AWS |
|-------|-----|
| Virtual Machine (VM) | EC2 Instance |
| VM Scale Set | Auto Scaling Group |
| Azure Image | AMI (Amazon Machine Image) |

### VM Components:

```
Virtual Machine
├── Compute        → CPU cores + RAM
├── OS Disk        → Boot disk (Windows/Linux OS)
├── Data Disks     → Additional storage (optional)
├── NIC            → Network Interface Card (IP address)
├── NSG            → Network Security Group (Firewall rules)
└── VNet           → Virtual Network (private network)
```

---

## 4. VM Deployment Types

### 🔷 Type 1 — Single Virtual Machine

**What it is:** One standalone VM that you fully control.

**Use cases:**
- Learning & hands-on practice ✅
- Development & testing environments ✅
- Running a small personal project ✅
- Quick application prototyping ✅

**Characteristics:**
- You manage: OS, software, updates, networking
- Full admin (root/administrator) access
- If the VM goes down → your app goes down (single point of failure)
- Cheapest option

```
You → Single VM → Your Application
```

> ⚠️ **Not recommended for production** — no redundancy or auto-recovery

---

### 🔷 Type 2 — VM Scale Set (VMSS)

**What it is:** A **group of identical VMs** that automatically scale in and out based on demand.

**Key Features:**
- **Autoscaling** — VMs are added when traffic increases, removed when traffic decreases
- **Load Balancing** — traffic is distributed evenly across all VMs
- **Batch Management** — manage 1 to **1,000 VMs** as a single unit
- **High Availability** — VMs spread across Availability Zones automatically

**Use cases:**
- High-traffic web applications 🌐
- Production environments 🏭
- E-commerce during sales events 🛒
- Video streaming platforms 📹
- Any workload with unpredictable traffic spikes

```
Low Traffic:                High Traffic:
                            
[LB] → [VM1] [VM2]         [LB] → [VM1][VM2][VM3][VM4][VM5]
                                   ↑ Auto-scaled up!
```

**Scaling Rules Example:**
```
Rule: If CPU > 70% for 5 minutes → Add 2 VMs
Rule: If CPU < 20% for 10 minutes → Remove 1 VM
Scale Range: Minimum 2 VMs, Maximum 10 VMs
```

---

### 🔷 Type 3 — Presets (Preconfigured VM Templates)

**What it is:** **Ready-made VM configurations** optimized for specific workloads. Instead of manually choosing every setting, Azure offers presets that are already tuned.

**Types of Presets:**

| Preset Type | Optimized For | Example Use |
|-------------|--------------|-------------|
| **General Purpose** | Balanced CPU & Memory | Web servers, dev/test |
| **Compute Optimized** | High CPU | Gaming, batch processing |
| **Memory Optimized** | High RAM | Databases, in-memory caching |
| **Storage Optimized** | High disk I/O | Big data, data warehouses |
| **GPU Optimized** | Graphics & AI | Machine Learning, rendering |

**Why Use Presets?**
- Saves time — no need to manually configure everything
- Optimized configurations by Microsoft engineers
- Deployed as customer needs — you can further customize after

---

### 🔷 Type 4 — Hybrid (Preconfigured + High Volume)

**What it is:** An **advanced deployment option** combining cloud VMs with on-premise (physical) servers — also known as **Hybrid Cloud**.

**Key Concepts:**

| Concept | Description |
|---------|-------------|
| **Azure Arc** | Manage on-premise servers from Azure portal |
| **Azure Site Recovery** | Replicate on-premise servers to Azure for disaster recovery |
| **Azure Migrate** | Tool to migrate company servers from on-premise to Azure |
| **Azure ExpressRoute** | Dedicated private connection from company office to Azure |
| **Azure VPN Gateway** | Encrypted tunnel from office network to Azure VNet |

**Use cases:**
- Large enterprises migrating from on-premise to cloud gradually
- Companies with compliance requirements to keep some data on-premise
- Combining existing physical servers with cloud VMs

```
Company Office (On-Premise)          Microsoft Azure
┌─────────────────────┐              ┌────────────────────┐
│  Physical Servers   │◄─ VPN/ExpressRoute ─►│  Azure VMs │
│  Local Databases    │              │  Azure Storage     │
│  Active Directory   │              │  Azure AD          │
└─────────────────────┘              └────────────────────┘
         Hybrid Cloud Setup
```

---

## 5. Availability Options — Explained in Detail

When creating a VM in Azure, you must choose an **Availability Option**. This determines **how protected your VM is** from failures.

---

### 🔴 Option 1 — No Infrastructure Redundancy Required

**What it means:** Just one VM, no protection against failures.

```
Single VM
[VM-1] ← if this fails, app is DOWN
```

**Characteristics:**
- ❌ No high availability
- ❌ No disaster recovery
- ❌ No failover
- ✅ Cheapest option
- ✅ Fine for dev/test/learning

**Risk:** If the physical hardware underneath your VM fails → **your application goes down**.

> Use this ONLY for: non-critical workloads, learning, testing, personal projects.

---

### 🟡 Option 2 — Availability Zone

**What it means:** Your VM is placed in a **specific physical data center (zone)** within a region. You can deploy multiple VMs across different zones for protection.

```
Region: Central India (Pune)
┌──────────────────────────────────────────┐
│  Zone 1       Zone 2        Zone 3       │
│  [VM-1]       [VM-2]        [VM-3]       │
│  DC-Pune-A    DC-Pune-B     DC-Pune-C    │
└──────────────────────────────────────────┘
If Zone 1 data centre fails → VM-2 and VM-3 still running ✅
```

**Characteristics:**
- ✅ Protects from **entire data center failure**
- ✅ 99.99% SLA (uptime guarantee) with 2+ zones
- ❌ **Higher cost** — you pay for multiple VMs
- ❌ Only available in regions that support AZs (e.g., Central India ✅, West India ❌)

**Best for:** Production applications, databases, anything that must stay online 24/7.

---

### 🟠 Option 3 — VM Scale Set (across Zones)

**What it means:** Azure **automatically creates and distributes VMs across all available zones**. You don't manually assign zones — Azure handles it.

```
VMSS with Zone Distribution:

Zone 1     Zone 2     Zone 3
[VM-1]     [VM-2]     [VM-3]
[VM-4]     [VM-5]     [VM-6]
     ↑ Auto-created and distributed by Azure
```

**Characteristics:**
- ✅ Auto-scaling based on demand
- ✅ Auto zone distribution
- ✅ Self-healing — failed VMs are replaced automatically
- ✅ Best for high-traffic production workloads
- ❌ More complex to set up and manage

---

### 🟢 Option 4 — Availability Set

**What it means:** Protects VMs from **hardware failures WITHIN a single data center**. VMs are distributed across different **Fault Domains** and **Update Domains**.

```
One Data Centre (e.g., West India - Mumbai)
┌───────────────────────────────────────────────┐
│                                               │
│  Fault Domain 0     Fault Domain 1            │
│  ┌────────────┐     ┌────────────┐            │
│  │   Rack A   │     │   Rack B   │            │
│  │  [VM-1]    │     │  [VM-2]    │            │
│  │  [VM-3]    │     │  [VM-4]    │            │
│  └────────────┘     └────────────┘            │
│         ↑                  ↑                  │
│    Own power/switch   Own power/switch        │
└───────────────────────────────────────────────┘
If Rack A hardware fails → VM-2 and VM-4 still running ✅
If entire data centre fails → ALL VMs go down ❌
```

**Two Key Concepts in Availability Sets:**

| Concept | What it means |
|---------|--------------|
| **Fault Domain** | A group of VMs sharing the same power & network switch (same rack). Max 3 fault domains. |
| **Update Domain** | A group of VMs that can be rebooted together during Azure maintenance. Max 20 update domains. |

**Characteristics:**
- ✅ Protects from **hardware failure inside one data center** (rack failure, switch failure)
- ✅ Protects from **Azure planned maintenance** (rolling reboots)
- ❌ Does **NOT** protect from full data center failure
- ✅ Free to use (you only pay for the VMs themselves)
- ✅ Available in **ALL regions** (even those without AZs like Mumbai, Chennai)

> **Key takeaway:** Availability Sets are the choice for regions WITHOUT Availability Zones (West India, South India).

---

### 📊 Availability Options — Side-by-Side Comparison

| Feature | No Redundancy | Availability Set | Availability Zone | VM Scale Set |
|---------|:-------------:|:----------------:|:-----------------:|:------------:|
| Protection from hardware failure | ❌ | ✅ (within DC) | ✅ | ✅ |
| Protection from DC failure | ❌ | ❌ | ✅ | ✅ |
| Auto-scaling | ❌ | ❌ | ❌ | ✅ |
| Auto distribution | ❌ | ✅ | Manual | ✅ |
| Available in all regions | ✅ | ✅ | ❌ (AZ regions only) | ✅ |
| SLA Uptime | 99.9% | 99.95% | 99.99% | 99.99% |
| Cost | Lowest | Low | Medium-High | High |
| Best For | Dev/Test | Legacy apps, non-AZ regions | Production | High-traffic production |

---

## 6. Ways to Connect to a Virtual Machine

Once your VM is running, you need a way to log in and manage it. Azure provides **4 methods**:

---

### 🔷 Method 1 — Azure Bastion (Jump Host)

**What it is:** A **fully managed, browser-based** way to securely connect to your VM directly from the Azure Portal — **without exposing a public IP**.

```
Your Browser → Azure Portal → Azure Bastion Service → Private VM
                              (No public IP needed on VM!)
```

**How it works:**
1. Go to Azure Portal → Your VM → **Connect → Bastion**
2. Enter username and password (or SSH key)
3. A terminal opens **right inside your browser**

**Advantages:**
- ✅ Most secure method — VM doesn't need a public IP
- ✅ No need to install any software on your laptop
- ✅ Works from any browser, any device
- ✅ Protected by Azure AD authentication
- ✅ All traffic is TLS encrypted
- ❌ **Not free** — Bastion has an hourly cost (~$0.19/hour)

**Best for:** Production VMs where security is the top priority.

> 💡 **"Jump Host"** = A server used as a stepping stone to reach another server securely. Bastion acts as the jump host managed by Azure.

---

### 🔷 Method 2 — SSH via Azure CLI (Command Line)

**What it is:** Connecting to a **Linux VM** using **SSH (Secure Shell)** through your local terminal or Azure Cloud Shell.

**Two ways to use SSH:**

**A) From your local machine:**
```bash
# Syntax
ssh username@<public-IP-of-VM>

# Example
ssh azureuser@20.195.123.45

# Using SSH key (more secure)
ssh -i ~/.ssh/mykey.pem azureuser@20.195.123.45
```

**B) Using Azure CLI:**
```bash
# Login to Azure
az login

# SSH into VM via Azure CLI
az ssh vm --resource-group MyRG --name MyVM
```

**How SSH Authentication Works:**
```
Your Machine                Azure VM
┌─────────────┐             ┌──────────────────┐
│ Private Key │◄──matched──►│ Public Key stored│
│ (your PC)   │             │ in VM (~/.ssh/)  │
└─────────────┘             └──────────────────┘
```

**Advantages:**
- ✅ Fast and lightweight
- ✅ Free (uses port 22 on NSG)
- ✅ Standard industry method for Linux servers
- ❌ Requires public IP on the VM
- ❌ Port 22 must be open in NSG (security risk if exposed to internet)

**Best for:** Linux VMs, developers comfortable with terminal.

---

### 🔷 Method 3 — RDP (Remote Desktop Protocol)

**What it is:** A **graphical desktop connection** to **Windows VMs**. Gives you a full Windows desktop interface remotely.

**How to connect:**
1. Open **Remote Desktop Connection** app on your Windows machine
   - Windows: Search "Remote Desktop Connection" or press `Win + R` → type `mstsc`
   - Mac: Download "Microsoft Remote Desktop" from App Store
2. Enter the **Public IP** of the VM
3. Enter **username and password**
4. Click **Connect** → Windows desktop appears!

```
Your Windows/Mac Desktop          Azure Windows VM
┌─────────────────────┐           ┌──────────────────┐
│                     │◄──RDP────►│  Windows Server  │
│  Remote Desktop App │  Port 3389│  Full GUI Desktop│
└─────────────────────┘           └──────────────────┘
```

**Advantages:**
- ✅ Full graphical Windows interface
- ✅ Copy-paste between local and remote machine
- ✅ Easy to use — just like sitting in front of the VM
- ❌ Only for **Windows VMs**
- ❌ Port 3389 must be open in NSG
- ❌ Higher bandwidth usage than SSH

**Best for:** Windows Server VMs, GUI-based administration tasks.

---

### 🔷 Method 4 — Serial Console

**What it is:** A **low-level emergency access** method that connects directly to the **serial port** of the VM — even when the OS is crashed, the network is down, or the VM is in a boot loop.

```
Normal Access (SSH/RDP/Bastion):     Serial Console:
Requires OS + Network working        Works EVEN if OS is crashed!
                                     
Azure Portal → VM → Serial Console
→ Direct hardware-level terminal
```

**When to use Serial Console:**
- VM is **stuck in a boot loop** and won't start
- You **locked yourself out** (wrong firewall rules blocking SSH/RDP)
- OS crashed and you need to **diagnose the issue**
- Network configuration is broken
- Emergency recovery situations

**Limitations:**
- ❌ **Read-only** in some situations
- ❌ Cannot transfer files
- ❌ Not for daily use
- ✅ Available 24/7 regardless of VM OS/network state

---

### 📊 Connection Methods — Comparison

| Method | OS Support | Needs Public IP | Cost | Use Case |
|--------|-----------|:--------------:|------|----------|
| **Bastion** | Linux + Windows | ❌ No | Paid (~$0.19/hr) | Secure production access |
| **SSH (CLI)** | Linux only | ✅ Yes | Free | Daily Linux VM management |
| **RDP** | Windows only | ✅ Yes | Free | Windows VM GUI access |
| **Serial Console** | Linux + Windows | ❌ No | Free | Emergency/recovery only |

---

## 7. VM Extensions

### 🧩 What are VM Extensions?

**VM Extensions** are **small add-on programs** that run on your VM to provide post-deployment configuration, automation, and monitoring — without you having to manually log in and install things.

Think of them as **plugins for your VM**.

### How Extensions Work:

```
VM Created
    ↓
Azure installs Extension Agent on VM
    ↓
You add extensions from Portal/CLI/ARM template
    ↓
Extension runs automatically inside the VM
```

### Common VM Extensions:

| Extension | Purpose |
|-----------|---------|
| **Custom Script Extension** | Run a shell script or PowerShell script on VM after deployment |
| **Azure Monitor Agent** | Collect logs and performance metrics and send to Azure Monitor |
| **Microsoft Antimalware** | Install and manage antivirus on Windows VMs |
| **Desired State Configuration (DSC)** | Enforce configuration compliance on Windows VMs |
| **Key Vault Extension** | Automatically rotate and inject certificates from Key Vault |
| **Diagnostics Extension** | Collect detailed diagnostics (CPU, memory, disk) |
| **Azure AD Login Extension** | Allow users to log in with Azure AD credentials instead of passwords |
| **Chef/Puppet Extension** | Integrate with Chef or Puppet configuration management tools |
| **NVIDIA GPU Extension** | Install GPU drivers automatically on GPU VMs |

### Custom Script Extension Example:

```bash
# This script runs automatically on VM after deployment
#!/bin/bash
apt-get update
apt-get install -y nginx
systemctl start nginx
echo "Hello from Azure VM!" > /var/www/html/index.html
```

You attach this via the portal or ARM template — **no need to manually SSH in**.

### Benefits of Extensions:
- ✅ Automate post-deployment tasks
- ✅ Install software without manual login
- ✅ Enforce security and compliance
- ✅ Integrate with monitoring tools
- ✅ Supports both Windows and Linux

---

## 8. VM Sizes & Pricing Tiers

### VM Size Naming Convention:

```
Standard_D4s_v3
    │    │ │  │
    │    │ │  └── Version (v3 = latest generation)
    │    │ └───── s = Premium SSD supported
    │    └──────── 4 = 4 vCPUs
    └───────────── D = General Purpose family
```

### VM Size Families:

| Series | Type | Best For |
|--------|------|----------|
| **A-series** | Entry-level | Dev/test, low-traffic |
| **B-series** | Burstable | Dev/test, small apps (B1s = FREE TIER) |
| **D-series** | General Purpose | Web servers, enterprise apps |
| **E-series** | Memory Optimized | Databases, in-memory workloads |
| **F-series** | Compute Optimized | Gaming, high-CPU tasks |
| **N-series** | GPU | AI/ML, graphics rendering |
| **L-series** | Storage Optimized | Big data, NoSQL |

### 🆓 Free Tier VM:
```
Size: B1s
vCPU: 1
RAM:  1 GB
Disk: 30 GB
Free: 750 hours/month for 12 months
OS:  Linux OR Windows (not both simultaneously)
```

---

## 9. VM Best Practices

### 🔐 Security:
- Always use **SSH keys** instead of passwords for Linux VMs
- **Restrict NSG rules** — only open ports you actually need
- Use **Azure Bastion** instead of exposing public IP for RDP/SSH
- Enable **Azure Defender for Servers** in production
- Regularly apply **OS updates and patches**

### 💰 Cost Optimization:
- **Stop (deallocate) VMs** when not in use — idle VMs still charge
- Use **Reserved Instances** (1 or 3 year commitment) for up to 72% discount
- Use **Spot VMs** for batch/test workloads — up to 90% cheaper (can be evicted)
- Right-size your VMs — don't use D8 when B2 is sufficient
- Set up **Auto-shutdown** schedules for dev/test VMs

### 🏗️ Architecture:
- Always use a **Resource Group** per project
- Use **Tags** on resources for cost tracking (`Env: Production`, `Team: Backend`)
- Put VMs inside a **Virtual Network (VNet)** — never expose directly to internet
- Use a **Load Balancer** in front of multiple VMs
- Enable **Backup** for production VMs using Azure Backup

---

## 10. Quick Reference Comparison Table

### AWS vs Azure Terminology

| Azure Term | AWS Equivalent | Description |
|-----------|---------------|-------------|
| Virtual Machine | EC2 Instance | Virtual server |
| VM Scale Set | Auto Scaling Group | Auto-scaling group of VMs |
| Resource Group | (No direct equivalent) | Logical container for resources |
| Azure VNet | AWS VPC | Private virtual network |
| NSG (Network Security Group) | Security Group | Firewall rules for VMs |
| Azure Bastion | AWS Systems Manager Session Manager | Secure browser-based access |
| Azure Load Balancer | AWS ELB (Classic) | Layer 4 load balancer |
| Application Gateway | AWS ALB | Layer 7 load balancer |
| Azure Monitor | AWS CloudWatch | Monitoring & alerting |
| Azure DevOps | AWS CodePipeline | CI/CD pipelines |
| Azure Active Directory | AWS IAM | Identity & access management |
| Availability Zone | Availability Zone | Isolated data center within region |
| Availability Set | Placement Group | Hardware fault isolation |

---

## 11. Key Terminologies Glossary

| Term | Definition |
|------|-----------|
| **VM (Virtual Machine)** | A software-based computer running on Azure hardware |
| **VMSS (VM Scale Set)** | Auto-scaling group of identical VMs |
| **Region** | Geographic location of Azure data centers |
| **Availability Zone (AZ)** | Physically separate data center within a region |
| **Availability Set** | Group of VMs distributed across fault/update domains within one DC |
| **Fault Domain** | Group of VMs sharing the same physical rack (power + network) |
| **Update Domain** | Group of VMs that reboot together during Azure maintenance |
| **NSG (Network Security Group)** | Firewall rules controlling inbound/outbound traffic to VMs |
| **VNet (Virtual Network)** | Private network in Azure where your VMs live |
| **Subnet** | Subdivision of a VNet for organizing resources |
| **Public IP** | IP address accessible from the internet |
| **Private IP** | IP address only accessible within the VNet |
| **SSH (Secure Shell)** | Encrypted protocol to connect to Linux servers |
| **RDP (Remote Desktop Protocol)** | Protocol to connect to Windows servers with GUI |
| **Azure Bastion** | Managed secure browser-based VM access service |
| **Serial Console** | Emergency low-level VM access via serial port |
| **VM Extension** | Add-on program that runs on VM for automation/monitoring |
| **SLA (Service Level Agreement)** | Microsoft's uptime guarantee for a service |
| **Latency** | Time delay in data transmission (lower = faster) |
| **On-Premise** | Physical servers hosted in your own office/data center |
| **Hybrid Cloud** | Combination of on-premise servers and cloud (Azure) |
| **Azure Arc** | Service to manage on-premise servers from Azure portal |
| **Autoscaling** | Automatic adding/removing of VMs based on demand |
| **Load Balancer** | Distributes incoming traffic across multiple VMs |
| **Health Probe** | Periodic check to see if a VM is alive and serving traffic |
| **Deallocated** | VM stopped and Azure resources released (no compute charge) |
| **Spot VM** | Low-cost VM that can be evicted by Azure when needed |
| **Reserved Instance** | Pre-purchase of VM capacity for 1–3 years at discount |

---


*Keep learning, keep building! ☁️ The cloud gets clearer every day.*
