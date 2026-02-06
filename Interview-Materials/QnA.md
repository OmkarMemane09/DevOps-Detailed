# AWS Core Concepts – GitHub Ready Notes

> Clean, structured, interview-ready notes focused on **understanding**, not rote learning.

---

## 1. Multi-AZ Deployment

### What is Multi-AZ?

Multi-AZ (Availability Zone) deployment means running the **same application/resources across two or more Availability Zones** within a single AWS Region.

* **Availability Zone (AZ)** = Physically separate data center
* AZs have independent power, cooling, and networking
* Connected via low-latency private AWS fiber

---

### Why Multi-AZ Exists

If your application runs in **only one AZ**, it has a **single point of failure**.

AWS does **not** automatically make your application highly available — **you must design for it**.

Multi-AZ provides:

* High availability
* Fault tolerance
* Automatic failover

---

### How Multi-AZ Works (Example)

```text
User → ALB → EC2 (AZ-A)
           → EC2 (AZ-B)
```

* Application Load Balancer distributes traffic across AZs
* If AZ-A fails, traffic automatically shifts to AZ-B

---

### AWS Services with Built-in Multi-AZ Support

* Application Load Balancer (ALB)
* Network Load Balancer (NLB)
* Auto Scaling Groups
* Amazon RDS (Multi-AZ)
* Amazon DynamoDB
* Amazon EFS

---

### Cost Implications (Important)

Multi-AZ is **NOT free**.

Extra cost comes from:

* Additional EC2 instances
* Data transfer between AZs
* Standby database resources

Use Multi-AZ **only for production or critical workloads**.

---

### When NOT to Use Multi-AZ

* Learning environments
* Personal projects
* Proof of concepts
* Batch jobs with retry logic

---

## 2. Cost Optimization in AWS

### What Cost Optimization Really Means

> Paying **only for required resources**, at the **right size**, for the **right duration**.

Most high AWS bills happen due to:

* Over-provisioning
* Idle resources
* Wrong pricing models

---

### Key Cost Optimization Techniques

#### 1. Right-Sizing

* Choose instance types based on **actual usage**, not assumptions
* Use CloudWatch & Compute Optimizer

---

#### 2. Auto Scaling

* Scale out during high traffic
* Scale in when idle
* Fixed capacity = wasted money

---

#### 3. Pricing Models

| Model                   | Use Case                  | Cost     |
| ----------------------- | ------------------------- | -------- |
| On-Demand               | Short-term, unpredictable | High     |
| Reserved / Savings Plan | Long-term workloads       | Medium   |
| Spot                    | Fault-tolerant jobs       | Very Low |

---

#### 4. Storage Optimization

* Move infrequently accessed data to:

  * S3 Standard-IA
  * S3 Glacier
* Delete unused EBS snapshots

---

#### 5. Stop Unused Resources

* Stopped EC2 still costs for:

  * EBS volumes
  * Elastic IPs
* Shut down dev/test environments after work hours

---

### Cost Optimization Tools

* AWS Cost Explorer
* AWS Budgets
* Trusted Advisor
* Compute Optimizer

---

## 3. Reducing Docker Image Size

### Why Image Size Matters

Large images cause:

* Slow builds
* Slow deployments
* Higher storage and bandwidth costs
* Bigger attack surface

---

### Techniques to Reduce Docker Image Size

#### 1. Use Lightweight Base Images

```dockerfile
FROM node:18-alpine
```

Avoid `ubuntu` unless required.

---

#### 2. Multi-Stage Builds

```dockerfile
FROM node:18-alpine AS build
RUN npm install

FROM node:18-alpine
COPY --from=build /app /app
```

Only runtime artifacts go into final image.

---

#### 3. Use `.dockerignore`

Exclude unnecessary files:

* `.git`
* Logs
* Docs

---

#### 4. Combine RUN Commands

```dockerfile
RUN apt update && apt install -y curl
```

Each RUN creates a new layer — fewer layers = smaller image.

---

## 4. Cloud Service Models

### IaaS – Infrastructure as a Service

**You manage:**

* OS
* Runtime
* Application

**AWS manages:**

* Hardware
* Networking

**Examples:**

* EC2
* EBS
* VPC

---

### PaaS – Platform as a Service

**You manage:**

* Application code

**AWS manages:**

* OS
* Runtime
* Scaling

**Examples:**

* Elastic Beanstalk
* Amazon RDS
* AWS Lambda (partially)

---

### SaaS – Software as a Service

**You manage:**

* Almost nothing

**Examples:**

* Gmail
* Salesforce
* AWS WorkSpaces

---

### Comparison Summary

| Model | Control | Operational Effort |
| ----- | ------- | ------------------ |
| IaaS  | High    | High               |
| PaaS  | Medium  | Medium             |
| SaaS  | Low     | Low                |

---

## 5. Hypervisor

### What is a Hypervisor?

A hypervisor is software that allows **multiple virtual machines (VMs)** to run on a **single physical server**.

It provides:

* Resource allocation (CPU, RAM)
* Isolation between VMs
* Virtualization

---

### Types of Hypervisors

#### Type 1 – Bare Metal Hypervisor

* Runs directly on hardware
* High performance and security

**Examples:**

* Xen
* KVM
* VMware ESXi

> AWS uses **Type 1 hypervisors**

---

#### Type 2 – Hosted Hypervisor

* Runs on top of an OS
* Used mainly for learning

**Examples:**

* VirtualBox
* VMware Workstation

---

### Hypervisor Used by AWS

* Earlier: **Xen**
* Current: **AWS Nitro Hypervisor**

Nitro offloads:

* Networking
* Storage
* Security

Result:

* Near bare-metal performance
* Strong isolation

---

### Popular Use Cases of Hypervisors

* Cloud computing (EC2)
* Server consolidation
* Running multiple OS on same hardware
* Secure isolation
* Disaster recovery

---

## Final Notes

* AWS rewards **design thinking**, not memorization
* Cost, availability, and performance are **trade-offs**
* Always ask: *Why does this service exist?*

---

---

## 6. CloudWatch Agent

### What is CloudWatch Agent?

CloudWatch Agent is a **software agent installed on EC2 or on‑prem servers** to collect **system‑level metrics and logs**.

---

### Why CloudWatch Agent is Needed

By default, EC2 sends only **basic metrics**:

* CPU Utilization
* Network In/Out

CloudWatch Agent enables:

* Memory usage
* Disk usage
* Custom application logs

---

### Key Features

* Collects metrics (CPU, RAM, disk, swap)
* Collects logs (application, system)
* Supports JSON‑based configuration
* Uses IAM role (no hardcoded credentials)

---

## 7. Git Restore vs Git Revert

### Git Restore

Used to **discard local changes**.

```bash
git restore file.txt
```

* Affects working directory or staging area
* Does NOT create a commit
* Dangerous if misused

---

### Git Revert

Used to **undo a committed change safely**.

```bash
git revert <commit-id>
```

* Creates a new commit
* Safe for shared branches
* Preferred in production

---

### Key Difference

| Feature              | Restore | Revert |
| -------------------- | ------- | ------ |
| Affects history      | No      | Yes    |
| Creates commit       | No      | Yes    |
| Safe for shared repo | ❌       | ✅      |

---

## 8. Custom Metrics in CloudWatch

### What are Custom Metrics?

Metrics **you define yourself** and push to CloudWatch.

Examples:

* Application response time
* Queue length
* Active users

---

### How Custom Metrics Work

```text
App → PutMetricData → CloudWatch
```

* Pushed via AWS SDK / CLI
* Charged per metric

---

### Why Use Custom Metrics

* Default metrics are not enough
* Better autoscaling decisions
* Business‑level visibility

---

## 9. Command Not Found Error

### Meaning

```bash
bash: xyz: command not found
```

The shell cannot locate the command.

---

### Common Causes

* Package not installed
* PATH variable misconfigured
* Typo in command
* Wrong shell

---

### How to Fix

```bash
which command
whereis command
echo $PATH
```

---

## 10. Kubernetes Security Best Practices

### Core Security Practices

* Use **RBAC** (least privilege)
* Enable **Network Policies**
* Scan images for vulnerabilities
* Use **Secrets**, not ConfigMaps for sensitive data
* Disable privileged containers

---

### Pod Security

* Run containers as non‑root
* Use read‑only file systems
* Set resource limits

---

## 11. Deployment Strategies

### 1. Recreate

* Old pods stopped → new pods started
* Downtime exists

---

### 2. Rolling Update (Default)

* Gradual replacement
* Zero downtime

---

### 3. Blue‑Green

* Two environments
* Instant rollback
* Higher cost

---

### 4. Canary

* Small % traffic to new version
* Safe experimentation

---

## 12. ReplicationController (RC) vs ReplicaSet (RS)

### ReplicationController

* Old Kubernetes object
* Supports only equality selectors

---

### ReplicaSet

* Newer, more flexible
* Supports set‑based selectors
* Used by Deployments

---

### Key Difference

| Feature       | RC      | RS       |
| ------------- | ------- | -------- |
| Used today    | ❌       | ✅        |
| Selector type | Limited | Advanced |

---

## 13. Can One EBS be Attached to Multiple EC2?

### Short Answer

❌ **No** (except special case).

---

### Details

* Standard EBS → only one EC2 at a time
* **EBS Multi‑Attach**:

  * Only for io1/io2
  * Same AZ
  * Application must handle locking

---

### Better Alternatives

* Amazon EFS
* S3

---

## 14. Git Stash vs Git Revert

### Git Stash

Temporarily saves local uncommitted changes.

```bash
git stash
git stash pop
```

---

### Git Revert

Reverts a committed change using a new commit.

---

### Key Difference

| Feature       | Stash | Revert |
| ------------- | ----- | ------ |
| Commit needed | No    | Yes    |
| Temporary     | Yes   | No     |

---

## 15. Git Restore vs Git Cherry‑Pick

### Git Restore

Used to discard or restore files.

---

### Git Cherry‑Pick

Apply **specific commit(s)** from one branch to another.

```bash
git cherry-pick <commit-id>
```

---

### Use Case

* Hotfix from main → release branch
* Selective commit transfer

---

## 1. Processes in Linux

### What is a Process?

A process is an **instance of a running program** loaded into memory.

Each process has:

* PID (Process ID)
* Its own memory space
* File descriptors
* Execution state

---

### Types of Processes

#### Foreground Process

* Runs in terminal
* Requires user interaction

#### Background Process

* Runs without blocking terminal

```bash
command &
```

#### Daemon Process

* Long‑running background service
* Starts at boot time

Examples:

* `sshd`
* `cron`
* `systemd`

---

### Common Process Commands

```bash
ps aux
top
htop
kill <pid>
kill -9 <pid>
```

---

## 2. How to Check Resource Usage from a Container

### Docker Containers

```bash
docker stats
```

Shows:

* CPU usage
* Memory usage
* Network I/O
* Block I/O

---

### Kubernetes Containers

```bash
kubectl top pod
kubectl top node
```

> Requires **metrics‑server** to be installed

---

### Inside a Container

```bash
top
free -m
cat /proc/meminfo
```

---

## 3. Process vs Thread

### Process

* Independent execution unit
* Own memory space
* Heavyweight
* More isolation

---

### Thread

* Lightweight execution unit
* Shares memory with process
* Faster communication
* Failure can crash entire process

---

### Comparison

| Feature       | Process  | Thread        |
| ------------- | -------- | ------------- |
| Memory        | Separate | Shared        |
| Overhead      | High     | Low           |
| Communication | IPC      | Shared memory |
| Isolation     | Strong   | Weak          |

---

## 4. 503 Error in Load Balancer & Other AWS Errors

### 503 – Service Unavailable

Occurs when **Load Balancer cannot forward traffic to healthy targets**.

---

### Common Causes

* No healthy targets in target group
* Failed health checks
* Application crash
* Wrong port or protocol
* Security group or NACL issue

---

### Other Common AWS Errors

| Error | Meaning         |
| ----- | --------------- |
| 4xx   | Client error    |
| 5xx   | Server error    |
| 502   | Bad Gateway     |
| 504   | Gateway Timeout |

---

### Troubleshooting Flow

1. Check target group health
2. Verify security groups
3. Check application logs
4. Validate scaling policies

---

## 5. Logs in CloudWatch & Monitoring

### What are CloudWatch Logs?

Centralized service to **collect, store, and monitor logs**.

---

### Key Components

* **Log Group** → Collection of logs
* **Log Stream** → Individual log source

---

### Managing & Monitoring Logs

* Set retention policies
* Create metric filters
* Trigger alarms
* Export logs to S3

---

### Best Practices

* Never keep logs forever
* Separate application & system logs
* Use structured logging (JSON)

---

## 6. PVC Policy (Kubernetes)

### What is PVC?

PersistentVolumeClaim is a request for persistent storage by a pod.

---

### Reclaim Policies

* **Retain** – Manual cleanup required
* **Delete** – Volume deleted with PVC
* **Recycle** – Deprecated

---

### Production Insight

> Use **Retain** for databases, **Delete** for temporary workloads.

---

## 7. How to See Versions of Pod and Service

### Pod Version

Pods don’t have versions directly.

Check:

* Image version
* Labels

```bash
kubectl describe pod <pod-name>
```

---

### Service Version

Services are version‑agnostic.

Versioning is handled using:

* Labels
* Selectors

---

## 8. Blocks in Terraform

### Core Terraform Blocks

```hcl
terraform {}
provider {}
resource {}
variable {}
output {}
module {}
```

---

### Purpose of Each Block

* `terraform` → Backend & version constraints
* `provider` → Cloud configuration
* `resource` → Infrastructure definition
* `module` → Reusable infrastructure

---

## 9. Geoproximity Routing Policy (Route 53)

### What is Geoproximity Routing?

Routes traffic based on **geographical location of users and resources**.

---

### Key Features

* Bias‑based traffic shifting
* Traffic steering between regions
* Requires Route 53 Traffic Flow

---

### Use Cases

* Disaster recovery
* Latency optimization
* Compliance‑based routing

---

## 10. sort vs uniq (Linux)

### sort Command

Sorts lines alphabetically or numerically.

```bash
sort file.txt
```

---

### uniq Command

Removes **adjacent duplicate lines only**.

```bash
sort file.txt | uniq
```

---

### Key Difference

| Command | Function           |
| ------- | ------------------ |
| sort    | Orders data        |
| uniq    | Removes duplicates |

---
# AWS, Kubernetes & Linux – Interview Notes (Set 3)

> Separate, structured, GitHub-ready notes focused on **real-world scenarios and interview depth**.

---

## 1. Making ALB Global Using CloudFront

### Problem Statement

ALB DNS is **regional**, but you want **global users** to access it with low latency.

---

### Solution: Use CloudFront in Front of ALB

```text
User (Global) → CloudFront → ALB → EC2 / ECS
```

---

### How to Do It

1. Create a **CloudFront distribution**
2. Set **Origin** as ALB DNS name
3. Configure:

   * HTTPS (ACM certificate)
   * Caching behavior
   * Security headers
4. Use CloudFront domain or custom domain

---

### Why Use CloudFront

* Global edge locations
* Reduced latency
* DDoS protection (Shield)
* Caching static content
* TLS termination

---

### Interview Insight

> ALB is not global — CloudFront makes it globally accessible.

---

## 2. SecOps

### What is SecOps?

SecOps integrates **Security + Operations** to ensure security is embedded into daily operations.

---

### Key Responsibilities

* Continuous security monitoring
* Vulnerability management
* Incident response
* Compliance automation

---

### Tools Used in SecOps

* AWS GuardDuty
* AWS Security Hub
* SIEM tools
* Trivy / Aqua / Falco

---

## 3. Subnet Requirements for RDS

### How Many Subnets Are Required?

* Minimum **2 subnets**
* Must be in **different Availability Zones**

---

### Subnet Group

RDS requires a **DB Subnet Group**.

---

### CIDR Range Recommendation

* /24 per subnet is standard
* Avoid very small CIDR blocks

---

### Interview Insight

> Multi-AZ RDS cannot exist in a single subnet.

---

## 4. CloudWatch Alarm States

### Alarm States

1. **OK** – Metric within threshold
2. **ALARM** – Threshold breached
3. **INSUFFICIENT_DATA** – Not enough data

---

### Alarm Use Cases

* Trigger Auto Scaling
* Send SNS notifications
* Detect failures

---

## 5. Listener & Listener Rules in ALB

### Listener

* Listens on a specific port
* Protocol: HTTP / HTTPS

---

### Listener Rules

* Path-based routing
* Host-based routing
* Header-based routing

---

### Example

```text
/api → Target Group A
/web → Target Group B
```

---

## 6. Auto Scaling Group Policies

### Types of Scaling Policies

1. Target Tracking (Recommended)
2. Step Scaling
3. Simple Scaling (Legacy)

---

### Scaling Triggers

* CPU utilization
* Custom CloudWatch metrics

---

### Interview Insight

> Target tracking is preferred due to automatic adjustment.

---

## 7. Security Practices in Kubernetes

### Cluster-Level Security

* Enable RBAC
* Use Network Policies
* Secure API server

---

### Pod-Level Security

* Run as non-root
* Set resource limits
* Use read-only filesystem

---

### Image Security

* Scan images
* Use trusted registries

---

## 8. sudoers File in Linux

### What is sudoers?

Defines **who can run what commands with sudo**.

---

### File Location

```bash
/etc/sudoers
```

---

### Safe Editing

```bash
visudo
```

---

### Example Entry

```text
omkar ALL=(ALL) NOPASSWD:ALL
```

---

## 9. Handling Sudden Traffic Spike in Kubernetes

### Immediate Actions

* Enable HPA
* Increase replica count
* Scale nodes (Cluster Autoscaler)

---

### Long-Term Solutions

* Use LoadBalancer / Ingress
* Enable caching
* Apply rate limiting

---

### Interview Insight

> Scaling pods without scaling nodes will still fail.

---

## 10. Unable to Terminate EC2 Instance

### Possible Reasons

* Termination protection enabled
* Instance part of Auto Scaling Group
* Insufficient IAM permissions

---

### How to Fix

1. Disable termination protection
2. Remove instance from ASG
3. Verify IAM policy

---

### Interview Insight

> ASG will recreate instances if manually terminated.

---

## 1. Creating a Network with Your Own CIDR (VPC)

### What Does It Mean?

Creating your own network in AWS means creating a **VPC with a custom CIDR block**.

---

### Steps

1. Choose CIDR range (private IP only):

   * `10.0.0.0/16`
   * `172.16.0.0/12`
   * `192.168.0.0/16`
2. Create VPC
3. Create subnets from that CIDR
4. Attach Internet Gateway
5. Configure Route Tables

---

### Interview Insight

> CIDR size decides how many IPs you can allocate in future.

---

## 2. CloudFront vs Terraform

### CloudFront

* CDN service
* Improves latency
* Distributes content globally

---

### Terraform

* Infrastructure as Code tool
* Used to **create and manage CloudFront**, not a replacement

---

### Key Difference

| Feature | CloudFront       | Terraform             |
| ------- | ---------------- | --------------------- |
| Type    | AWS Service      | IaC Tool              |
| Purpose | Content delivery | Resource provisioning |

---

## 3. One Instance Unhealthy in Target Group

### What It Means

ALB marks instance unhealthy due to **failed health checks**.

---

### Common Causes

* Application down
* Wrong health check path
* Security group blocking LB
* Port mismatch
* High CPU/memory

---

### How to Handle

1. Check target group health
2. Verify health check path
3. Check application logs
4. Restart service / replace instance
5. ASG will auto-replace if configured

---

## 4. Remote Repository vs Local Repository (Git)

### Local Repository

* Exists on developer machine
* Faster operations

---

### Remote Repository

* Centralized copy (GitHub, GitLab)
* Used for collaboration

---

### Interview Insight

> Git is distributed — every local repo has full history.

---

## 5. EKS Volumes & Bootable Volumes

### Boot Volume

* Root EBS volume attached to worker node
* Contains OS

---

### Pod Volumes

* EBS via CSI driver
* EFS for shared storage

---

### Important Point

> Pods are NOT bootable — nodes are.

---

## 6. Low Latency with CloudFront

### How CloudFront Reduces Latency

* Edge caching
* TLS termination at edge
* Optimized AWS backbone

---

### Best Practices

* Cache static content
* Set correct TTL
* Use compression
* Choose closest edge location

---

## 7. Monitoring AWS Console Access & User Activity

### Service Used: AWS CloudTrail

Tracks:

* Console logins
* API calls
* Resource creation

---

### How to Monitor

* Enable CloudTrail
* Send logs to S3
* Integrate with CloudWatch Logs
* Create alarms

---

### Example Use Case

> Who launched an EC2 instance?

---

## 8. How AWS Lambda Works

### What is Lambda?

Serverless compute service that runs code **only when triggered**.

---

### Execution Flow

```text
Event → Lambda → Execution Environment → Response
```

---

### Key Characteristics

* No server management
* Auto scaling
* Pay per execution

---

## 9. Nested Stacks in CloudFormation

### What is a Nested Stack?

A CloudFormation stack inside another stack.

---

### Why Use Nested Stacks

* Reusability
* Better organization
* Easier maintenance

---

### Example Use Case

* One stack for VPC
* One for EC2
* One for RDS

---

## 10. Read Replicas vs Multi-AZ

### Read Replica

* Improves read scalability
* Asynchronous replication
* Used for reporting

---

### Multi-AZ

* High availability
* Synchronous replication
* Automatic failover

---

### Key Difference

| Feature  | Read Replica | Multi-AZ     |
| -------- | ------------ | ------------ |
| Purpose  | Scaling      | Availability |
| Failover | Manual       | Automatic    |

---

### Interview Insight

> Read replicas do NOT provide HA.

---
## 1. RDS Proxy – How It Works & Why It Is Used

### Definition
- RDS Proxy is a **fully managed database connection pool** for Amazon RDS and Aurora.

### How It Works
- Application connects to **RDS Proxy endpoint**, not directly to DB.
- Proxy maintains a pool of reusable DB connections.
- Automatically handles **failover**.
- IAM authentication supported.

### Why Use It
- Prevents **connection exhaustion**.
- Ideal for **Lambda, ECS, Auto Scaling** workloads.
- Improves availability during DB failover.

### When Not Required
- Long-running EC2 apps with stable traffic.
- Low-connection workloads.

---

## 2. Deployment Strategies

### Types

- **Recreate**
  - Stop old version, deploy new
  - Causes downtime

- **Rolling**
  - Gradual replacement
  - Default Kubernetes strategy

- **Blue/Green**
  - Two environments
  - Zero downtime, easy rollback

- **Canary**
  - Release to small traffic %
  - Risk-controlled production rollout

- **Shadow**
  - Duplicate traffic
  - Testing only, no user impact

---

## 3. Git Pull vs Git Fetch

### git fetch
- Downloads changes only
- Does NOT modify working branch
- Safe operation

### git pull
- git fetch + git merge
- Can introduce conflicts

### Best Practice
```bash
git fetch
git diff origin/main
git merge origin/main
4. Merge Conflict – How to Resolve
Causes
Same lines modified differently by multiple commits

Resolution Steps
Open conflicted file

Understand logic

Remove conflict markers

Keep correct code

Test changes

Commit

5. Git Workflow (Practical)
Common Branches
main → production

develop → integration

feature/* → development

Flow
Feature → PR → Review → Merge

6. Why Use Docker When We Have VMs
Virtual Machines
Heavy

Own OS

Slow boot

Docker Containers
Lightweight

Shared kernel

Fast startup

Portable

Core Reason
Environment consistency (dev = prod)

7. Docker Network Drivers
bridge – Default, single host

host – No isolation, high performance

none – No networking

overlay – Multi-host networking

macvlan – Container gets real IP

8. Stateless vs Stateful Applications
Stateless
No local data storage

Easy scaling

Load balancer friendly

Stateful
Stores data

Requires persistent volumes

Complex scaling

9. S3 Cost Optimization
Use proper storage classes

Enable lifecycle policies

Delete unused objects

Remove incomplete multipart uploads

Compress data

10. AWS Security & Cost Optimization
Security
IAM least privilege

MFA enabled

Security Groups

NACLs

CloudTrail logging

Cost
Right-size EC2

Spot Instances

Reserved Instances

Auto Scaling

Remove unused resources

11. Kubernetes Pod Issues
CrashLoopBackOff
Application error

Wrong env variables

Image issues

Resource limits exceeded

Pending State
No available nodes

Insufficient CPU/Memory

PVC not bound

Node selector mismatch

Debug Commands
kubectl describe pod <pod-name>
kubectl logs <pod-name>




