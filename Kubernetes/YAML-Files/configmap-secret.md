```bash
apiVersion: v1
kind: ConfigMap
metadata:
  name: my-config
data:
  PASSWORD: "KaliLinux"
  USERNAME: "root"
  CITY: "Pune"
```

### kubectl apply -f configmap.yml
### kubectl get configmap my-config -o yaml
### kubectl describe configmap my-config  

```bash
apiVersion: v1
kind: Pod 
metadata:
  name: configmap-pod
  labels:
    app: webserve
spec:
   containers:
    - name: nginx-container
      image: nginx
      ports:
      - containerPort: 80
      env:
      - name: APP_PASSWORD
        valueFrom:
          configMapKeyRef:
            name: my-config
            key: PASSWORD
      - name: APP_USERNAME
        valueFrom:
          configMapKeyRef:
            name: my-config
            key: USERNAME
      - name: APP_CITY
        valueFrom:
          configMapKeyRef:
            name: my-config
            key: CITY   
```
### kubectl apply -f pod.yml
### kubectl get pod configmap-pod -o yaml
### kubectl describe pod configmap-pod    

-----------------------------------
## Secret
```bash
echo -n 'some-secret-api-key' | base64             # for PASSWORD
echo -n 'password123' | base64                     # for USERNAME
```

```bash
apiVersion: v1
kind: Secret
metadata:
  name: my-secret
data: 
  PASSWORD: c29tZS1zZWNyZXQtYXBpLWtleQ==  
  USERNAME: cGFzc3dvcmQxMjM=    
```

### kubectl apply -f secret.yml
### kubectl get secret my-secret -o yaml 
### kubectl describe secret my-secret
```bash
apiVersion: v1
kind: Pod
metadata:
  name: secret-pod
  labels:
    app: database
spec:
  containers:
  - name: mysql
    image: mysql
    ports:
    - containerPort: 3306
    env:
    - name: MY_SQL_ROOT_PASSWORD
      valueFrom:
        secretKeyRef:
          name: secret-pod
          key: PASSWORD
    - name: MY_USERNAME
      valueFrom:
        secretKeyRef:
          name: secret-pod
          key: PASSWORD    
```

### kubectl apply -f pod.yml
### kubectl get pod secret-pod -o yaml
### kubectl describe pod secret-pod
