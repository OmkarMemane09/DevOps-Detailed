
##  Deployments 

A **Deployment** ensures a desired number of interchangeable Pod replicas are available at any given time, making them ideal for stateless applications.

#### Features of Deployments
- **Stateless**: All pods are identical and interchangeable.
- **Rolling Updates**: Supports zero-downtime deployments.
- **Fast Rollback**: Instantly revert to previous versions.
- **Simple Scaling**: Add or remove any number of replicas at once.
- **Pod Identity**: Pods have random names and are replaced freely.
- 
## Deployment Strategies

- **Recreate:** Terminates all old Pods before creating new ones (potential downtime).
- **Rolling Update:** Updates Pods incrementally for minimal downtime (most common).
- **Canary Deployment:** Deploy a small subset of new Pods to test before full rollout.
- **Blue-Green Deployment:** Deploy a parallel set of Pods and switch traffic after verification.

#### Use Cases
- Web servers (e.g., Nginx, Apache)
- REST APIs and backend services
- Any stateless microservice


### Workflow

1. **Write/Edit Manifest:**  
   ```bash
   nano deployment.yaml
   ```

2. **Apply Manifest:**
   ```bash
   kubectl apply -f deployment.yaml
   ```

3. **Check:**
   ```bash
     kubectl get deployments
   ```

4. **Clean up:**  
   ```bash
   kubectl delete -f deployment.yaml
   ```

### Manifest for a Deployment
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-deployment
  labels:
    app: my-app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: my-app
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
  template:
    metadata:
      labels:
        app: my-app
    spec:
      containers:
        - name: nginx
          image: nginx:latest
          ports:
            - containerPort: 80

```
---
### 1. Create a Deployment

```bash
kubectl create deployment nginx-deployment --image=nginx
```
**Use**
Creates a Deployment with 1 replica and an associated ReplicaSet.

**Output**

`deployment.apps/nginx-deployment created`

---
### 2. Apply Deployment from YAML (Declarative way)
```bash
kubectl apply -f deployment.yaml
```
**Use**
Creates or updates a Deployment based on YAML definition.

**Output**

`
deployment.apps/nginx-deployment created
`
or
`
deployment.apps/nginx-deployment configured
`

---

### 3. List all Deployments
```bash
kubectl get deployments
```
**Use**
Shows all Deployments in the current namespace.

**Output**
```bash
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deployment   3/3     3            3           10m
```

---
### 4. Get a Specific Deployment
```bash
kubectl get deployment nginx-deployment
```
**Use**
Shows high-level status of a Deployment.

**Output**
```bash
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deployment   3/3     3            3           10m
```

---
### 5. Describe a Deployment (Most Important)
```bash
kubectl describe deployment nginx-deployment
```
**Use**
Shows complete details:

 - Image

 - Strategy

 - ReplicaSets

 - Events

**Output**
```bash
Containers:
  nginx:
    Image: nginx:1.16.1
StrategyType: RollingUpdate
Events:
  ScalingReplicaSet nginx-deployment-abc123 to 3
```

---
### 6. Scale a Deployment
```bash
kubectl scale deployment nginx-deployment --replicas=5
```
**Use**
Changes the number of Pod replicas.

**Output**

`deployment.apps/nginx-deployment scaled`

---
### 7. Update Image of a Deployment
```bash
kubectl set image deployment/nginx-deployment nginx=nginx:1.16.1
```
**Use**
Triggers a rolling update by changing container image.

**Output**
`
deployment.apps/nginx-deployment image updated`

---
### 8. Check Rollout Status
```bash
kubectl rollout status deployment/nginx-deployment
```
**Use**
Checks whether the latest rollout is complete or still in progress.

**Output**
`
deployment "nginx-deployment" successfully rolled out `

---
### 9. View Rollout History (Revisions)
```bash
kubectl rollout history deployment/nginx-deployment
```
**Use**
Shows previous Deployment revisions.

**Output**
```bash
REVISION  CHANGE-CAUSE
1         <none>
2         <none>
```

---
### 10. View Details of a Specific Revision
```bash
kubectl rollout history deployment/nginx-deployment --revision=1
```
**Use**
Shows image and spec used in an older revision.

**Output**
`
Image: nginx:1.14.2`

---
### 11. Rollback Deployment (Undo Last Change)
```bash
kubectl rollout undo deployment/nginx-deployment
```
**Use**
Rolls back to the previous revision.

**Output**
`
deployment.apps/nginx-deployment rolled back`

---
### 12. Rollback to a Specific Revision
```bash
kubectl rollout undo deployment/nginx-deployment --to-revision=1
```
**Use**
Rolls back to a chosen revision.

**Output**
`
deployment.apps/nginx-deployment rolled back`

---
### 13. Pause a Deployment
```bash
kubectl rollout pause deployment/nginx-deployment
```
**Use**
Pauses rollout (useful before multiple changes).

**Output**
```bash
deployment.apps/nginx-deployment paused
```

---
### 14. Resume a Deployment
```bash
kubectl rollout resume deployment/nginx-deployment
```
**Use**
Resumes a paused rollout.

**Output**

`
deployment.apps/nginx-deployment resumed`

---
### 15. Get Pods Created by a Deployment
```bash
kubectl get pods -l app=nginx
```
**Use**
Lists Pods managed by the Deployment (via labels).

**Output**
```bash
nginx-deployment-abc123   Running
nginx-deployment-def456   Running
```
---
### 16. Delete a Deployment
```bash
kubectl delete deployment nginx-deployment
```
**Use**
Deletes Deployment, ReplicaSet, and Pods.

**Output**
`
deployment.apps "nginx-deployment" deleted`

---
### 17. Extract Deployment YAML
```bash
kubectl get deployment nginx-deployment -o yaml
```
**Use**
Exports the full Deployment definition.

**Output**
```bash
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
```
---

### 18. Check Which ReplicaSet Deployment Uses
```bash
kubectl get rs
```
**Use**
Shows ReplicaSets created by Deployments.

**Output**
```bash
NAME                          DESIRED   CURRENT   READY   AGE
nginx-deployment-abc123       3         3         3       5m
```
