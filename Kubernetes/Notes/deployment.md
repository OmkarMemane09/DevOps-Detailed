# Kubernetes Deployment – kubectl Commands Cheat Sheet

This document lists all commonly used **Deployment-related kubectl commands** with:
- Purpose (why you use it)
- Example command
- Typical output (simplified)

---

## 1. Create a Deployment

### Command
```bash
kubectl create deployment nginx-deployment --image=nginx
Use
Creates a Deployment with 1 replica and an associated ReplicaSet.

Output
bash
Copy code
deployment.apps/nginx-deployment created
2. Apply Deployment from YAML (Declarative way)
Command
bash
Copy code
kubectl apply -f deployment.yaml
Use
Creates or updates a Deployment based on YAML definition.

Output
bash
Copy code
deployment.apps/nginx-deployment created
or

bash
Copy code
deployment.apps/nginx-deployment configured
3. List all Deployments
Command
bash
Copy code
kubectl get deployments
Use
Shows all Deployments in the current namespace.

Output
pgsql
Copy code
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deployment   3/3     3            3           10m
4. Get a Specific Deployment
Command
bash
Copy code
kubectl get deployment nginx-deployment
Use
Shows high-level status of a Deployment.

Output
pgsql
Copy code
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deployment   3/3     3            3           10m
5. Describe a Deployment (Most Important)
Command
bash
Copy code
kubectl describe deployment nginx-deployment
Use
Shows complete details:

Image

Strategy

ReplicaSets

Events

Output (snippet)
yaml
Copy code
Containers:
  nginx:
    Image: nginx:1.16.1
StrategyType: RollingUpdate
Events:
  ScalingReplicaSet nginx-deployment-abc123 to 3
6. Scale a Deployment
Command
bash
Copy code
kubectl scale deployment nginx-deployment --replicas=5
Use
Changes the number of Pod replicas.

Output
bash
Copy code
deployment.apps/nginx-deployment scaled
7. Update Image of a Deployment
Command
bash
Copy code
kubectl set image deployment/nginx-deployment nginx=nginx:1.16.1
Use
Triggers a rolling update by changing container image.

Output
arduino
Copy code
deployment.apps/nginx-deployment image updated
8. Check Rollout Status
Command
bash
Copy code
kubectl rollout status deployment/nginx-deployment
Use
Checks whether the latest rollout is complete or still in progress.

Output
csharp
Copy code
deployment "nginx-deployment" successfully rolled out
9. View Rollout History (Revisions)
Command
bash
Copy code
kubectl rollout history deployment/nginx-deployment
Use
Shows previous Deployment revisions.

Output
nginx
Copy code
REVISION  CHANGE-CAUSE
1         <none>
2         <none>
10. View Details of a Specific Revision
Command
bash
Copy code
kubectl rollout history deployment/nginx-deployment --revision=1
Use
Shows image and spec used in an older revision.

Output (snippet)
css
Copy code
Image: nginx:1.14.2
11. Rollback Deployment (Undo Last Change)
Command
bash
Copy code
kubectl rollout undo deployment/nginx-deployment
Use
Rolls back to the previous revision.

Output
bash
Copy code
deployment.apps/nginx-deployment rolled back
12. Rollback to a Specific Revision
Command
bash
Copy code
kubectl rollout undo deployment/nginx-deployment --to-revision=1
Use
Rolls back to a chosen revision.

Output
bash
Copy code
deployment.apps/nginx-deployment rolled back
13. Pause a Deployment
Command
bash
Copy code
kubectl rollout pause deployment/nginx-deployment
Use
Pauses rollout (useful before multiple changes).

Output
bash
Copy code
deployment.apps/nginx-deployment paused
14. Resume a Deployment
Command
bash
Copy code
kubectl rollout resume deployment/nginx-deployment
Use
Resumes a paused rollout.

Output
bash
Copy code
deployment.apps/nginx-deployment resumed
15. Get Pods Created by a Deployment
Command
bash
Copy code
kubectl get pods -l app=nginx
Use
Lists Pods managed by the Deployment (via labels).

Output
sql
Copy code
nginx-deployment-abc123   Running
nginx-deployment-def456   Running
16. Delete a Deployment
Command
bash
Copy code
kubectl delete deployment nginx-deployment
Use
Deletes Deployment, ReplicaSet, and Pods.

Output
arduino
Copy code
deployment.apps "nginx-deployment" deleted
17. Extract Deployment YAML
Command
bash
Copy code
kubectl get deployment nginx-deployment -o yaml
Use
Exports the full Deployment definition.

Output
yaml
Copy code
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
...
18. Check Which ReplicaSet Deployment Uses
Command
bash
Copy code
kubectl get rs
Use
Shows ReplicaSets created by Deployments.

Output
pgsql
Copy code
NAME                          DESIRED   CURRENT   READY   AGE
nginx-deployment-abc123       3         3         3       5m
