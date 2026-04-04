
# 🛡️ Trivy — Security Scanner for DevSecOps

> **Trivy** is an open-source, all-in-one security scanner built for DevOps and DevSecOps workflows.  
> One tool. One command. Comprehensive vulnerability detection.

---

## 📌 What is Trivy?

Trivy (by Aqua Security) is a **simple yet powerful open-source vulnerability and misconfiguration scanner** designed for:

- Container Images
- File Systems
- Git Repositories
- Kubernetes clusters
- CI/CD Pipelines
- Infrastructure as Code (IaC)

It helps teams practice **Shift Left Security** — detecting security issues *early* in the development lifecycle, before they reach production.

---

## 🔍 What Does Trivy Scan For?

| Category | Description |
|---|---|
| **CVEs** | Common Vulnerabilities and Exposures in OS packages & libraries |
| **Misconfigurations** | Issues in Dockerfile, Kubernetes YAML, Terraform, etc. |
| **Secrets** | Hardcoded API keys, passwords, tokens in code |
| **License Risks** | Unapproved open-source licenses |
| **SBOM** | Software Bill of Materials generation |

---

## 🧩 CVE — Common Vulnerabilities and Exposures

A **CVE** is a publicly disclosed security vulnerability with a unique identifier.

### CVE Structure

```
CVE-YEAR-XXXXXXX
Example: CVE-2021-44228  ← (Log4Shell)
```

### Each CVE Contains:

- **ID** → Unique identifier (e.g., `CVE-2021-44228`)
- **Severity** → `CRITICAL` | `HIGH` | `MEDIUM` | `LOW` | `UNKNOWN`
- **Description** → What the vulnerability is and how it can be exploited
- **Fix / Patch** → The version that resolves the issue
- **CVSS Score** → Numeric severity rating (0.0 – 10.0)

### Severity Scale

```
CRITICAL  →  CVSS 9.0 – 10.0  🔴  Immediate action required
HIGH      →  CVSS 7.0 – 8.9   🟠  Fix as soon as possible
MEDIUM    →  CVSS 4.0 – 6.9   🟡  Plan to fix soon
LOW       →  CVSS 0.1 – 3.9   🟢  Fix when convenient
UNKNOWN   →  No CVSS score    ⚪  Review manually
```

---

## 🗄️ Vulnerability Databases Used by Trivy

Trivy pulls from **trusted, up-to-date vulnerability databases**:

| Database | Source |
|---|---|
| **NVD** | National Vulnerability Database (NIST) |
| **GitHub Advisory DB** | GitHub Security Advisories |
| **OSV** | Open Source Vulnerabilities |
| **RedHat** | RedHat Security Advisories |
| **Debian / Ubuntu** | Distro-specific security data |
| **Alpine SecDB** | Alpine Linux Security Database |
| **Trivy DB** | Aggregated DB maintained by Aqua Security |

Trivy automatically updates its local DB before scanning.

---

## ⚙️ Installation

```bash
# macOS (Homebrew)
brew install trivy

# Linux (Script)
curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin

# Docker
docker pull aquasec/trivy

# Check version
trivy --version
```

---

## 🚀 Core Commands — One Command Vulnerability Scan

### 1. 🐳 Image Scanning

```bash
# Scan a Docker image
trivy image nginx:latest

# Scan with severity filter
trivy image --severity HIGH,CRITICAL nginx:latest

# Scan a locally built image
trivy image my-app:v1.0

# Output as JSON
trivy image -f json -o results.json nginx:latest

# Scan image from a tar file
trivy image --input myimage.tar
```

### 2. 📁 File System Scanning

```bash
# Scan current directory
trivy fs .

# Scan a specific path
trivy fs /path/to/project

# Scan for secrets too
trivy fs --scanners secret .

# Scan with config (IaC misconfigurations)
trivy fs --scanners config .
```

### 3. 📦 Repository Scanning

```bash
# Scan a remote GitHub repo
trivy repo https://github.com/username/repo

# Scan local repo
trivy repo .

# Scan with all scanners
trivy repo --scanners vuln,secret,config .
```

### 4. ☸️ Kubernetes Scanning

```bash
# Scan entire cluster
trivy k8s --report summary cluster

# Scan a specific namespace
trivy k8s --namespace default --report all

# Scan a single resource
trivy k8s deployment/my-app

# Output as table
trivy k8s --report summary --format table cluster
```

### 5. 📄 YAML / IaC / Config Scanning

```bash
# Scan Kubernetes YAML files
trivy config ./k8s-manifests/

# Scan Dockerfile
trivy config ./Dockerfile

# Scan Terraform files
trivy config ./terraform/

# Scan Helm charts
trivy config ./helm-chart/
```

---

## 🔄 CI/CD Integration

### GitHub Actions

```yaml
# .github/workflows/trivy-scan.yml
name: Trivy Security Scan

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  trivy-scan:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Run Trivy vulnerability scanner
        uses: aquasecurity/trivy-action@master
        with:
          image-ref: 'your-image:latest'
          format: 'sarif'
          output: 'trivy-results.sarif'
          severity: 'CRITICAL,HIGH'

      - name: Upload Trivy scan results to GitHub Security
        uses: github/codeql-action/upload-sarif@v2
        with:
          sarif_file: 'trivy-results.sarif'
```

### GitLab CI

```yaml
# .gitlab-ci.yml
trivy-scan:
  image: aquasec/trivy:latest
  script:
    - trivy image --exit-code 1 --severity HIGH,CRITICAL $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA
  allow_failure: false
```

### Jenkins Pipeline

```groovy
// Jenkinsfile
stage('Security Scan') {
    steps {
        sh 'trivy image --exit-code 1 --severity HIGH,CRITICAL myapp:latest'
    }
}
```

---

## 🏗️ DevSecOps — Shift Left Security

### What is Shift Left?

**Shift Left** means moving security checks *earlier* in the SDLC (Software Development Life Cycle) — from production back to development.

```
Traditional (Shift Right):
Dev → Build → Test → Deploy → [Security Check] → Production
                                       ↑
                               Too late! Issues found here are expensive

Shift Left with Trivy:
Dev → [Security Check] → Build → [Security Check] → Deploy → Production
       ↑ Code commit              ↑ CI/CD pipeline
  Catch issues early!         Catch before deploy!
```

### Why Early Detection Matters

| Stage | Cost to Fix |
|---|---|
| Development | 💚 Low — fix before commit |
| Build/CI | 🟡 Medium — fix before merge |
| Staging | 🟠 High — fix before release |
| Production | 🔴 Very High — breach risk + downtime |

---

## 📊 Trivy Output Formats

```bash
# Table (default - human readable)
trivy image nginx:latest

# JSON (for automation/parsing)
trivy image -f json nginx:latest

# SARIF (for GitHub/GitLab Security tab)
trivy image -f sarif nginx:latest

# CycloneDX SBOM
trivy image -f cyclonedx nginx:latest

# SPDX SBOM
trivy image -f spdx-json nginx:latest

# Template-based custom output
trivy image --format template --template "@contrib/html.tpl" nginx:latest
```

---

## 🔧 Useful Flags & Options

```bash
# Ignore unfixed vulnerabilities
trivy image --ignore-unfixed nginx:latest

# Exit with code 1 if vulnerabilities found (for CI/CD)
trivy image --exit-code 1 --severity CRITICAL nginx:latest

# Skip specific CVEs (use .trivyignore file)
trivy image --ignorefile .trivyignore nginx:latest

# Set timeout
trivy image --timeout 10m nginx:latest

# Quiet mode (less output)
trivy image -q nginx:latest

# Skip db update (offline mode)
trivy image --skip-db-update nginx:latest

# Cache dir
trivy image --cache-dir /tmp/trivy-cache nginx:latest
```

---

## 📝 .trivyignore File

Ignore specific CVEs across scans:

```bash
# .trivyignore
# Format: CVE-ID [expiration date] [comment]

CVE-2021-12345
CVE-2022-67890 exp:2024-12-31
CVE-2023-11111 # false positive, not applicable
```

---

## 🏷️ Trivy Scanning Summary

```
┌─────────────────────────────────────────────────────────┐
│                    TRIVY SCAN TYPES                     │
├────────────────┬────────────────────────────────────────┤
│  trivy image   │  Scan container images for CVEs        │
│  trivy fs      │  Scan file system / local directories  │
│  trivy repo    │  Scan Git repositories                 │
│  trivy config  │  Scan IaC / YAML / Dockerfile configs  │
│  trivy k8s     │  Scan Kubernetes clusters              │
│  trivy sbom    │  Generate Software Bill of Materials   │
└────────────────┴────────────────────────────────────────┘
```

---

## 🧠 Key Concepts Summary

| Term | Meaning |
|---|---|
| **CVE** | Common Vulnerabilities and Exposures — a unique ID for each known vulnerability |
| **CVSS** | Common Vulnerability Scoring System — numeric severity rating |
| **SBOM** | Software Bill of Materials — inventory of all components in software |
| **Shift Left** | Moving security checks earlier in the dev pipeline |
| **IaC** | Infrastructure as Code — Terraform, Helm, K8s YAML |
| **Misconfiguration** | Security issues in config files (e.g., privileged containers) |
| **Secret Scanning** | Detecting hardcoded credentials in source code |

---

## 📚 Resources

- 🔗 Official Docs: [https://aquasecurity.github.io/trivy](https://aquasecurity.github.io/trivy)
- 🐙 GitHub: [https://github.com/aquasecurity/trivy](https://github.com/aquasecurity/trivy)
- 📦 Trivy DB: Updated every 6 hours from upstream sources
- 🎓 Aqua Security Blog: Security best practices and tutorials

---

> 💡 **Pro Tip:** Always run `trivy image --severity HIGH,CRITICAL --exit-code 1` in your CI/CD pipeline to **block deployments** with critical vulnerabilities automatically!

---

*Notes created for DevSecOps learning — Trivy v0.50+*
