#  Services 
**A Kubernetes Service is an abstraction that provides a stable network identity and access policy for a dynamic set of Pods, enabling reliable communication and load balancing despite Pod IP changes.**

**In short:**  
`A Service exposes a group of Pods using a fixed IP/DNS so clients can reliably access them.`

---

## Why Services Are Needed

- Pods are **ephemeral** (they can be destroyed and recreated)
- Pod IP addresses **change**
- Direct Pod-to-Pod communication is unreliable

**Service solves this by:**
- Providing a stable endpoint
- Load-balancing traffic
- Automatically tracking healthy Pods

---

## How a Service Works

1. Pods are labeled (e.g., `app: nginx`)
2. Service selects Pods using label selectors
3. Kubernetes creates a **virtual IP (ClusterIP)**
4. Traffic sent to the Service is routed to matching Pods

Client → Service (Virtual IP) → kube-proxy → Pod IP

yaml
Copy code

> A Service is **virtual** — it does not run containers or processes.

---

## Key Components of a Service

```yaml
selector:
  app: nginx
ports:
- port: 80
  targetPort: 8080
```

selector → identifies target Pods

port → Service port

targetPort → container port

endpoints → automatically maintained list of Pod IPs

## Types of Kubernetes Services

**1. ClusterIP (Default)**
Accessible only inside the cluster

Assigned a virtual internal IP

```yaml
type: ClusterIP
```
Use cases:

 - Internal microservices

 - Backend APIs

 - Databases

Note:
Not accessible from outside the cluster.

---
**2. NodePort**
Exposes the Service on a static port on every node

Port range: 30000–32767

```yaml
type: NodePort
nodePort: 30080
```

Use cases:

 - Development and testing

 - Demos

 - Limitations:

 - Security risk

Not recommended for production

---
**3. LoadBalancer**
Creates a cloud provider load balancer

Assigns an external public IP

```yaml
type: LoadBalancer
```
Use cases:

 - Production applications

 - Internet-facing services

*Requirements:*

 - Supported cloud provider (AWS, GCP, Azure)

 - Involves cost
