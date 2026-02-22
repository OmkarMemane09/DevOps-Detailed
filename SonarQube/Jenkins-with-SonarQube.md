# Jenkins + SonarQube Integration Guide (EC2 Setup)

This documentation explains how to integrate **Jenkins** and **SonarQube** using AWS EC2 instances to perform automated code quality analysis in a CI/CD pipeline.

---

#  Architecture Overview

| Component | Purpose |
|-----------|----------|
| Jenkins | CI/CD automation server |
| SonarQube | Static code analysis & quality gate enforcement |
| EC2 Instance 1 | Jenkins Server |
| EC2 Instance 2 | SonarQube Server |
| Maven | Build & dependency management tool |

---

#  1. Create EC2 Instances

Launch **two EC2 instances**:

### Instance 1 → Jenkins Server
- Instance type: `t2.medium` or higher
- Open Ports:
  - `8080` (Jenkins UI)
  - `22` (SSH)

### Instance 2 → SonarQube Server
- Instance type: `t2.medium` or higher
- Open Ports:
  - `9000` (SonarQube UI)
  - `22` (SSH)

### Why separate instances?
- Better isolation  
- Improved performance  
- Production-like architecture  
- Easier scaling and maintenance  

---

#  2. Setup Jenkins Server (EC2)

## Install Java 17

```bash
sudo apt update
sudo apt install openjdk-17-jdk -y
```

**Why?**  
Jenkins requires Java to run.

---

## Install Jenkins

Follow official documentation:

👉 https://www.jenkins.io/doc/book/installing/

After installation, access:

```
http://<jenkins-public-ip>:8080
```

Unlock Jenkins and complete setup.

---

## Install Maven

```bash
sudo apt install maven -y
```

**Why?**
- Compile code  
- Run tests  
- Generate artifacts  
- Trigger Sonar analysis  

---

#  3. Setup SonarQube Server (EC2)

## Install Docker

```bash
sudo apt update
sudo apt install docker.io -y
```

## Run SonarQube

```bash
docker run -d --name sonarqube-custom -p 9000:9000 sonarqube:10.6-community
```

Access:

```
http://<sonarqube-public-ip>:9000
```

Login:
- Username: `admin`
- Password: `admin`

 Change password immediately.

---

#  4. Configure SonarQube

## Create Webhook

Go to:

```
Administration → Configuration → Webhooks → Create
```

| Field | Value |
|-------|--------|
| Name | Sonar-webhook |
| URL | http://<jenkins-public-ip>:8080/sonarqube-webhook/ |

### Why webhook?
It allows SonarQube to notify Jenkins about:
- Analysis completion
- Quality Gate status

---

## Create Project

Navigate to:

```
Projects → Create Project → Local Project
```

Fill:
- Project Name: `studentapp`
- Project Key: `studentapp`
- Main branch: `main`

Generate token → Copy and save securely.

---

#  5. Configure Jenkins

## Install Plugin

```
Manage Jenkins → Plugins → Available Plugins
```

Install:
```
SonarQube Scanner for Jenkins
```

---

## Add Sonar Token as Credential

```
Manage Jenkins → Credentials → Global → Add Credentials
```

| Field | Value |
|--------|--------|
| Kind | Secret Text |
| Secret | SonarQube Token |
| ID | sonar-token |

---

## Configure SonarQube Server in Jenkins

```
Manage Jenkins → System → SonarQube Servers
```

Add:

| Field | Value |
|--------|--------|
| Name | Sonar-env |
| Server URL | http://<sonarqube-public-ip>:9000 |
| Authentication Token | sonar-token |

Enable:
```
Environment variables
```

Save changes.

Optional restart:
```
http://<jenkins-ip>:8080/restart
```

---

#  6. Update pom.xml

Add Sonar plugin:

```xml
<build>
  <plugins>
    <plugin>
      <groupId>org.sonarsource.scanner.maven</groupId>
      <artifactId>sonar-maven-plugin</artifactId>
      <version>3.10.0.2594</version>
    </plugin>
  </plugins>
</build>
```

---

#  7. Jenkins Pipeline

**Create → New Item → Pipeline**


```groovy
pipeline {
    agent any

    stages {

        stage('clone repository') {
            steps {
                git branch: 'main', url: 'https://github.com/Rohit-1920/EasyCRUD.git'
            }
        }

        stage('build') {
            steps {
                sh '''
                cd backend
                mvn clean package -DskipTests
                '''
            }
        }

        stage('sonar analysis') {
            steps {
                withSonarQubeEnv('Sonar-env') {
                    sh '''
                    cd backend
                    mvn sonar:sonar \
                    -Dsonar.projectKey=studentapp \
                    -Dsonar.projectName=studentapp \
                    -DskipTests
                    '''
                }
            }
        }

        stage('Quality Gate') {
            steps {
                timeout(time: 10, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }

        stage('deploy') {
            steps {
                echo 'deployment stage'
            }
        }
    }
}
```

---

#  Pipeline Flow

1. Clone repository  
2. Build project  
3. Run Sonar analysis  
4. Wait for Quality Gate  
5. Deploy if passed  

---

#  What SonarQube Checks

| Category | Description |
|----------|------------|
| Bugs | Runtime risks |
| Vulnerabilities | Security issues |
| Code Smells | Maintainability problems |
| Security Hotspots | Sensitive code |
| Duplications | Repeated logic |
| Coverage | Test coverage |

---

#  Common Issues

| Issue | Cause | Fix |
|-------|-------|------|
| Quality Gate not updating | Webhook missing | Configure webhook |
| Sonar stage fails | Token incorrect | Check credentials |
| Cannot connect to Sonar | Port 9000 blocked | Update security group |
| Pipeline hangs | Wrong webhook URL | Correct URL |

---

#  Final Result

After setup:

- Push code  
- Jenkins builds  
- Sonar analyzes  
- Quality Gate validates  
- Deployment proceeds only if clean  

---

#  Summary

| Tool | Role |
|-------|-------|
| Jenkins | CI/CD automation |
| SonarQube | Code quality & security |
| Maven | Build tool |
| EC2 | Infrastructure hosting |

This setup ensures production-ready, secure, and maintainable code before deployment.
