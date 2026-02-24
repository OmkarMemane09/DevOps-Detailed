## 1️⃣ How does an Application Load Balancer distribute traffic?  
### What happens if one instance becomes unhealthy?

### ✅ How ALB Distributes Traffic

An Application Load Balancer (ALB) operates at **Layer 7 (HTTP/HTTPS)** of the OSI model.

It distributes traffic using:

- Round Robin (default)
- Least outstanding requests
- Path-based routing
- Host-based routing

### 🔄 Flow:

Client → ALB → Target Group → EC2 Instances

- ALB receives HTTP/HTTPS request.
- Forwards request to a **Target Group**.
- Target Group routes traffic to healthy EC2 instances.

### 💔 If One Instance Becomes Unhealthy:

- ALB performs **health checks** (HTTP endpoint like `/health`).
- If health check fails:
  - Instance marked **Unhealthy**
  - Traffic immediately stopped to that instance
  - Auto Scaling may terminate and replace it

✅ Zero downtime (if properly configured across AZs)

---

## 2️⃣ Horizontal vs Vertical Scaling

### 🔹 Vertical Scaling (Scale Up)

- Increase instance size
- Example: `t3.micro → t3.large`
- Add more CPU/RAM to same machine

**Pros:**
- Simple
- No architecture change

**Cons:**
- Downtime required
- Hardware limit
- Expensive at scale

---

### 🔹 Horizontal Scaling (Scale Out)

- Add more EC2 instances
- Managed via Auto Scaling Group

**Pros:**
- High availability
- Fault tolerant
- Infinite scaling potential

**Cons:**
- Requires Load Balancer
- More architectural complexity

### 🎯 When to Use?

| Scenario | Scaling Type |
|----------|--------------|
| Small app | Vertical |
| Production system | Horizontal |
| High traffic spikes | Horizontal |
| Legacy monolith | Vertical (initially) |

---

## 3️⃣ How Auto Scaling Decides to Launch/Terminate Instances?

Auto Scaling works using:

- Launch Template
- Auto Scaling Group
- Scaling Policies
- CloudWatch Metrics

### 📊 Common Metrics Used:

- CPU Utilization
- Request Count per Target (ALB metric)
- Network In/Out
- Custom application metrics

### Example Policy:

If CPU > 70% for 5 minutes → Add 1 instance  
If CPU < 30% for 10 minutes → Remove 1 instance  

### Types of Scaling Policies:

- Target Tracking Scaling
- Step Scaling
- Scheduled Scaling
- Predictive Scaling

---

## 4️⃣ Designing High Availability Across Multiple AZs

### ✅ Best Practices:

- Deploy EC2 in **at least 2 Availability Zones**
- Enable ALB across multiple AZs
- Use Auto Scaling with min=2 instances
- Enable RDS Multi-AZ

### Architecture:

```
        ALB
       /    \
   AZ-1      AZ-2
  EC2-1      EC2-2
       \    /
       RDS (Multi-AZ)
```

If one AZ fails:
- ALB routes traffic to other AZ
- RDS fails over automatically

---

## 5️⃣ What Happens to User Sessions if EC2 is Terminated?

If sessions are stored in:
- Local memory → ❌ LOST
- Local file system → ❌ LOST

### ✅ Proper Session Handling:

1. Store sessions in:
   - Redis (ElastiCache)
   - RDS
   - DynamoDB

2. Or enable ALB Sticky Sessions (not ideal for scale)

### Best Practice:
Stateless application + external session store

---

## 6️⃣ Securing Communication Between Web Tier and Database Tier

### 🔐 Security Best Practices:

1. RDS in **Private Subnet**
2. No public IP for RDS
3. Security Group rules:
   - RDS allows inbound ONLY from EC2 SG
4. Enable SSL/TLS encryption
5. Use IAM authentication (if supported)
6. Encrypt RDS storage (KMS)

### Example Security Flow:

Internet → ALB (Public Subnet)  
ALB → EC2 (Private Subnet)  
EC2 → RDS (Private Subnet)  

---

## 7️⃣ Multi-AZ vs Read Replicas in RDS

| Feature | Multi-AZ | Read Replica |
|----------|----------|--------------|
| Purpose | High Availability | Read Scaling |
| Sync Type | Synchronous | Asynchronous |
| Failover | Automatic | Manual |
| Write Capability | Primary only | No (read-only) |

### 🔥 Key Difference:

- Multi-AZ = Backup copy (for failure)
- Read Replica = Performance scaling

Use both in production.

---

## 8️⃣ Security Groups vs NACLs

### 🔹 Security Groups

- Instance-level firewall
- Stateful
- Allow rules only
- Evaluates all rules before decision

### 🔹 NACL (Network ACL)

- Subnet-level firewall
- Stateless
- Allow + Deny rules
- Evaluated in order

### When to Use Both?

- Security Groups → Primary security
- NACL → Extra layer of defense (e.g., block specific IP ranges)

---

## 9️⃣ Reducing Database Bottlenecks Under Heavy Load

### 🚀 Strategies:

1. Add Read Replicas
2. Enable Connection Pooling
3. Use Caching (Redis / ElastiCache)
4. Optimize queries (indexes)
5. Vertical scaling (increase DB instance class)
6. Sharding (for extreme scale)
7. Offload read-heavy traffic to replicas

### Real Optimization Stack:

User → ALB → EC2  
             ↓  
         Redis Cache  
             ↓  
          RDS Primary  
             ↓  
        Read Replicas  

---

## 🔟 Calculating Monthly Cost & Optimizing It

### 💰 Major Cost Components:

- EC2 instances
- RDS instance
- ALB hours + LCU usage
- Data transfer
- EBS storage
- NAT Gateway
- CloudWatch

---

### 📊 Basic Cost Estimation Formula

EC2 cost = Instance hourly price × 730 hours × number of instances  
RDS cost = DB hourly price × 730  
ALB cost = hourly charge + LCU usage  

Use:
- AWS Pricing Calculator

---

### 💡 Cost Optimization Strategies:

- Use Reserved Instances / Savings Plans
- Use Spot Instances (non-critical workloads)
- Right-size instances
- Enable Auto Scaling
- Use Graviton instances
- Turn off non-prod at night
- Monitor using Cost Explorer

---
