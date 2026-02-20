# SonarQube Code Quality Analysis Setup (EC2 + Docker + Maven)

## Overview

This guide explains how to:

- Launch an EC2 instance
- Install Docker
- Run SonarQube using Docker
- Create a project and generate a token
- Clone a Spring Boot project
- Run Sonar analysis using Maven

---

# 🏗 Architecture Flow

EC2 Instance  
   ↓  
Docker  
   ↓  
SonarQube Container (Port 9000)  
   ↓  
Maven Sonar Scanner  
   ↓  
Code Analysis Results in SonarQube UI  

---

# Step 1: Launch EC2 Instance

### Recommended Configuration

- Instance Type: **t3.medium** (Minimum 4GB RAM recommended)
- OS: Ubuntu 22.04
- Security Group Ports:
  - 22 (SSH)
  - 9000 (SonarQube UI)

### Connect to EC2
### Step 2: Install Docker
```bash
sudo apt update
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
```
Log out and log back in after adding user to docker group.

Verify installation:
```bash
docker --version
```
### Step 3: Run SonarQube Container
```bash
docker run -d --name sonarqube-custom -p 9000:9000 sonarqube:10.6-community
```
**Access SonarQube in browser:**
```bash
http://<EC2-PUBLIC-IP>:9000
```

**Default Credentials**
 - Username: admin
 - Password: admin

### Step 4: Create Project & Generate Token

> Login to SonarQube

> Click Create Project

**Enter:**

 - Project Key: studentapp

 - Project Name: studentapp

 - Generate a User Token

Copy the generated token

### Step 5: Set Sonar Token as Environment Variable
```bash
export SONAR_TOKEN=your_generated_token
```
> Using environment variables is more secure than hardcoding tokens.

###  Step 6: Clone Backend Repository
```bash
git clone <your-repository-url>
cd backend
```
### Step 7: Install Java 17
```bash
sudo apt install openjdk-17-jdk -y
java -version
mvn -version
```
Ensure Maven is using Java 17.

### Step 8: Build Project
```bash
mvn clean package -DskipTests
```
**This step:**

 - Compiles the project

 - Packages the JAR file

 - Skips tests (useful if database is not configured)

### Step 9: Run SonarQube Analysis
```bash
mvn clean verify sonar:sonar -DskipTests \
  -Dsonar.projectKey=studentapp \
  -Dsonar.projectName=studentapp \
  -Dsonar.host.url=http://<EC2-PUBLIC-IP>:9000 \
  -Dsonar.token=$SONAR_TOKEN
```

#### What This Command Does
 - Phase	Purpose
 - clean	Removes old build artifacts
 - verify	Compiles and validates project
 - sonar:sonar	Scans code and uploads report to SonarQube
 - 
#### SonarQube Dashboard Metrics

 - After successful analysis, SonarQube provides:

 - Lines of Code

 - Security Issues (Vulnerabilities)

 - Reliability Issues (Bugs)

 - Maintainability Issues (Code Smells)

 - Code Coverage (if JaCoCo configured)

 - Duplicated Code Percentage

### Common Issues & Fixes

### 1️. Java Version Error
 error: release version 17 not supported

Solution:
Install and configure Java 17 properly.

### 2️ SonarQube Container Keeps Stopping

Reason: Insufficient RAM.

Solution: Use at least 4GB RAM (t3.medium recommended).

### 3️ sonar.organization Error

Occurs when SonarCloud is used instead of local SonarQube.

Solution: Always specify:

-Dsonar.host.url=http://<EC2-IP>:9000
