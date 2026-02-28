# Monitor NGINX Pod Logs on Datadog
 This guide shows how to correctly install Datadog on Amazon EKS and collect NGINX pod logs, without common installation errors.
## Prerequisites
Make sure you have:

- ✅ An EKS cluster (nodes in Ready state)
- ✅ kubectl configured (aws eks update-kubeconfig)
- ✅ Helm v3+
- ✅ A Datadog account
- ✅ Datadog API Key
- ✅ Datadog Application Key
- ✅ Datadog site:
   - datadoghq.com → https://app.datadoghq.com
   - datadoghq.eu → https://app.datadoghq.eu
   - us3.datadoghq.com → https://app.us3.datadoghq.com
⚠️ Important:
The Datadog UI URL (app.datadoghq.com) is NOT the value used in Helm.
Always use datadoghq.com, datadoghq.eu, or us3.datadoghq.com.

## Helm Installation
```bash
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```
### verify
```sh
helm version
```

## Step 1: Create Datadog Namespace & Secrets
### 1️⃣ Create namespace
```sh
kubectl create namespace datadog
```
### 2️⃣ Create API Key secret
```sh
kubectl create secret generic datadog-secret \
  --from-literal=api-key=<YOUR_DATADOG_API_KEY> \
  -n datadog
```
📍 API Key location:
Datadog → Integrations → APIs → API Keys
### 3️⃣ Create Application Key secret (REQUIRED)
 This step is mandatory.
Missing this causes CreateContainerConfigError in datadog-cluster-agent.
```sh
kubectl create secret generic datadog-app-secret \
  --from-literal=app-key=<YOUR_DATADOG_APP_KEY> \
  -n datadog
```
📍 Application Key location:
Datadog → Organization Settings → Application Keys

## 🧩 Step 2: Add Datadog Helm Repository
```sh
helm repo add datadog https://helm.datadoghq.com
helm repo update
```
## Step 3: Create Helm Values File (datadog-values.yaml)
✅ This file is clean, non-duplicated, and non-deprecated.
```yaml
datadog:
  apiKeyExistingSecret: datadog-secret
  appKeyExistingSecret: datadog-app-secret
  site: datadoghq.com            # change only if EU or US3
  clusterName: my-eks-cluster

  logs:
    enabled: true
    containerCollectAll: true

  apm:
    portEnabled: true

  processAgent:
    enabled: true
    processCollectionEnabled: true

  orchestratorExplorer:
    enabled: true

clusterAgent:
  enabled: true
  replicas: 2
  pdb:
    create: true

agent:
  containerLogs:
    enabled: true
```

## Step 4: Install Datadog Using Helm
```sh
helm upgrade --install datadog-agent datadog/datadog \
  -f datadog-values.yaml \
  -n datadog
```
Restart agents to apply config:
```sh
kubectl rollout restart daemonset datadog-agent -n datadog
kubectl rollout restart deployment datadog-agent-cluster-agent -n datadog
```
## 
Step 5: Verify Datadog Installation
```
kubectl get pods -n datadog
```
Expected output:
```sql
datadog-agent-xxxxx                2/2 Running
datadog-agent-cluster-agent        1/1 Running
datadog-agent-operator             1/1 Running
```

❌ If you see CreateContainerConfigError, re-check:

- datadog-app-secret
- key name is exactly app-key
- secret exists in datadog namespace

## Step 6: Deploy Sample NGINX Application
```sh
kubectl create deployment nginx --image=nginx:latest
kubectl expose deployment nginx --port=80 --type=NodePort
```
verify:
```sh
kubectl get pods
kubectl get svc
```
## Step 7: Verify in Datadog UI

### Kubernetes Resources
Datadog → Infrastructure → Kubernetes
- Cluster visible
- Nodes visible
- Pods visible (including nginx)
⚠️ If a pod doesn’t appear:
 - Ensure Namespace = all namespaces
 - Generate CPU/log activity
 - Search manually: kube_pod_name:nginx

### Logs
Datadog → Logs → Explorer
Search:
```makeile
service:nginx
```

## Cleanup (Optional)
```bash
helm uninstall datadog-agent -n datadog
kubectl delete deployment nginx
kubectl delete service nginx
kubectl delete namespace datadog
```















