
# 18. Have You Ever Used Git Tags? If Yes, Why?

## Interview Answer

Yes. Git Tags are used to mark important points in a repository's history, typically for software releases such as `v1.0.0`, `v2.0.1`, etc.

Unlike branches, tags are intended to remain unchanged and provide a stable reference to a specific commit.

---

## Why Use Git Tags?

Common uses:

- Mark production releases
- Version application deployments
- Rollback to previous versions
- Trigger CI/CD release pipelines

---

## Types of Tags

### Lightweight Tag

```bash
git tag v1.0
```

Acts like a bookmark to a commit.

---

### Annotated Tag (Recommended)

```bash
git tag -a v1.0 -m "First Production Release"
```

Stores additional metadata:

- Tag name
- Creator
- Date
- Message

---

## View Tags

```bash
git tag
```

---

## Push Tag

```bash
git push origin v1.0
```

Push all tags:

```bash
git push origin --tags
```

---

## Delete Tag

Local:

```bash
git tag -d v1.0
```

Remote:

```bash
git push origin --delete v1.0
```

---

## Production Example

```
v1.0.0 → Initial Release
v1.1.0 → Added Login
v1.2.0 → Payment Gateway
v2.0.0 → Major Upgrade
```

CI/CD tools can deploy based on these tags.

---

# 19. Explain the Git Branching Strategy Used in Your Company

## Interview Answer

A common strategy is **Feature Branching**.

- `main` contains production-ready code.
- Developers create separate feature branches.
- Changes are reviewed through Pull Requests.
- After approval, branches are merged into `main`.
- Feature branches are then deleted.

---

## Workflow

```
main
 │
 ├── feature/login
 ├── feature/payment
 ├── feature/profile
 └── bugfix/session-timeout
```

---

## Typical Development Flow

```bash
git checkout main

git pull origin main

git checkout -b feature/login
```

Work on the feature.

Commit changes:

```bash
git add .

git commit -m "Added login feature"
```

Push:

```bash
git push origin feature/login
```

Open a Pull Request.

After review:

- Merge into `main`
- Delete the feature branch

---

## Other Branching Strategies

### Git Flow

Branches:

```
main

develop

feature

release

hotfix
```

Best suited for large teams and structured release cycles.

---

### Trunk-Based Development

Everyone commits to a single main branch using short-lived feature branches.

Common in organizations with continuous deployment.

---

# 20. Explain 3 Challenges That You Faced with Git

> **As a fresher, answer honestly.** Instead of claiming production experience, explain challenges commonly encountered in academic or personal projects.

---

## Challenge 1 – Merge Conflict

### Problem

Two team members modified the same file.

### Solution

- Pulled latest changes.
- Resolved the conflict manually.
- Tested the application.
- Committed the resolved version.

---

## Challenge 2 – Wrong Commit

### Problem

Accidentally committed a debug file.

### Solution

Removed the file from tracking:

```bash
git rm --cached debug.log
```

Added it to `.gitignore`.

Committed the fix.

---

## Challenge 3 – Accidental Push to Wrong Branch

### Problem

Changes were pushed to `main` instead of a feature branch.

### Solution

- Informed the team immediately.
- Created a corrective commit or reverted the changes.
- Followed the team's review process.

---

# 21. Explain the Recent Git Challenge You Faced and How You Addressed It

## Fresher-Friendly Answer

During our college project, two teammates modified the same Java file simultaneously.

When I attempted to merge my branch, Git reported a merge conflict.

I:

1. Read the conflict markers.
2. Discussed the intended changes with my teammate.
3. Kept the required code.
4. Removed the conflict markers.
5. Tested the application.
6. Committed the resolved version.

This taught me the importance of pulling the latest changes frequently and working on smaller feature branches.

---

# 22. How Do You Handle Merge Conflicts?

## Interview Answer

A merge conflict occurs when Git cannot automatically merge changes because the same lines of code were modified in different branches.

The correct approach is:

1. Identify the conflicting files.
2. Review the conflicting changes.
3. Decide which changes to keep.
4. Remove conflict markers.
5. Test the application.
6. Commit the resolved changes.

---

## Commands

Start merge:

```bash
git merge feature/login
```

Git reports:

```
CONFLICT (content)
```

View status:

```bash
git status
```

Open the conflicting file.

Example:

```text
<<<<<<< HEAD
System.out.println("Version A");
=======
System.out.println("Version B");
>>>>>>> feature/login
```

Edit the file:

```java
System.out.println("Version A");
System.out.println("Version B");
```

or choose the appropriate version.

Stage the resolved file:

```bash
git add Login.java
```

Complete the merge:

```bash
git commit
```

---

# 23. Explain Git Merge Strategies – Ours and Theirs

## Ours Strategy

Keeps the current branch's changes.

Example:

```bash
git merge -X ours feature/login
```

Use when the current branch should take precedence during conflicts.

---

## Theirs Strategy

Keeps the incoming branch's conflicting changes.

Example (during conflict resolution):

```bash
git checkout --theirs Login.java
git add Login.java
git commit
```

Use when the incoming changes should replace the local conflicting changes.

> **Note:** There is no direct `git merge -X theirs` strategy equivalent for all merge cases; `--theirs` is typically used while resolving conflicts.

---

# 24. Create a Merge Conflict and Resolve It

## Step 1 – Create Repository

```bash
mkdir git-demo
cd git-demo

git init
```

---

## Step 2 – Create File

```bash
echo "Version 1" > app.txt

git add .

git commit -m "Initial Commit"
```

---

## Step 3 – Create Feature Branch

```bash
git checkout -b feature
```

Edit:

```
Version from Feature Branch
```

Commit:

```bash
git add .

git commit -m "Feature Update"
```

---

## Step 4 – Switch to Main

```bash
git checkout main
```

Edit the same line:

```
Version from Main Branch
```

Commit:

```bash
git add .

git commit -m "Main Update"
```

---

## Step 5 – Merge

```bash
git merge feature
```

Output:

```
CONFLICT (content)
```

---

## Step 6 – Resolve Conflict

Git shows:

```text
<<<<<<< HEAD
Version from Main Branch
=======
Version from Feature Branch
>>>>>>> feature
```

Choose the correct content, remove the markers, save the file.

---

## Step 7 – Complete the Merge

```bash
git add app.txt

git commit -m "Resolved merge conflict"
```

---

# 25. Practical Lab – Create a Feature Branch and Resolve a Merge Conflict

### Create Repository

```bash
mkdir git-lab
cd git-lab

git init
```

### Create Initial File

```bash
echo "Welcome" > index.html

git add .

git commit -m "Initial Commit"
```

### Create Feature Branch

```bash
git checkout -b feature/login
```

Modify:

```html
<h1>Login Feature</h1>
```

Commit:

```bash
git add .

git commit -m "Added Login"
```

### Switch Back

```bash
git checkout main
```

Modify the same line:

```html
<h1>Main Page Updated</h1>
```

Commit:

```bash
git add .

git commit -m "Updated Main Page"
```

### Merge

```bash
git merge feature/login
```

Git reports a conflict.

### Resolve

Edit `index.html`, remove the conflict markers, keep the correct content.

Complete:

```bash
git add index.html

git commit -m "Merge conflict resolved"
```

---

# Common Git Interview Tips

- Do **not** force push (`git push --force`) to shared branches unless absolutely necessary. Prefer `git push --force-with-lease` when rewriting history.
- Pull the latest changes before starting new work.
- Commit small, meaningful changes with descriptive messages.
- Use Pull Requests for code review.
- Keep feature branches short-lived.
- Never commit secrets, passwords, API keys, or PEM files.
- Use tags for releases.
- Resolve merge conflicts carefully and test the application before committing.

---

# Quick Revision Table

| Topic | Key Point |
|--------|-----------|
| Squash Commits | `git rebase -i` |
| Fetch | Downloads changes only |
| Pull | Fetch + Merge |
| Merge | Preserves history |
| Rebase | Creates linear history |
| Fork | Your own remote copy |
| Clone | Local copy |
| Tag | Marks releases |
| `.git` | Stores repository metadata |
| Merge Conflict | Resolve manually, then commit |
| `.gitignore` | Ignore files from version control |
| Secret Leak | Rotate secrets, remove from history, use a secret manager |
# 7. Explain a Scenario Where You Used Git Fork Instead of Git Clone

## Interview Answer

I use **Git Fork** when I want to contribute to a repository that I do not have write access to. Forking creates my own copy of the repository in my GitHub account, allowing me to make changes safely without affecting the original repository. After completing my work, I create a Pull Request (PR) to request the maintainers to review and merge my changes.

---

## When to Use Git Fork

Use Git Fork when:

- Contributing to open-source projects
- You don't have write access to the original repository
- Working on public repositories
- You want an independent copy of the project

---

## Workflow

```
Original Repository
        │
        ▼
     Git Fork
        │
        ▼
Your GitHub Repository
        │
        ▼
Git Clone
        │
        ▼
Local Machine
        │
        ▼
Create Branch
        │
        ▼
Commit Changes
        │
        ▼
Push Changes
        │
        ▼
Pull Request
        │
        ▼
Original Repository
```

---

## Real Production Example

Suppose you want to contribute to the Kubernetes project.

You cannot directly push code to:

```
https://github.com/kubernetes/kubernetes
```

Instead:

1. Fork repository.
2. Clone your fork.
3. Create feature branch.
4. Commit changes.
5. Push to your repository.
6. Create Pull Request.

---

## Interview Tip

Git Fork is generally used in **Open Source Development**, while Git Clone is used inside organizations where developers already have repository access.

---

# 8. Git Fork in Action (Example)

## Step 1

Fork repository

```
https://github.com/example/project
```

GitHub creates

```
https://github.com/yourname/project
```

---

## Step 2

Clone your fork

```bash
git clone https://github.com/yourname/project.git
```

---

## Step 3

Move inside repository

```bash
cd project
```

---

## Step 4

Create branch

```bash
git checkout -b feature/login
```

---

## Step 5

Modify files

```bash
nano login.java
```

---

## Step 6

Commit

```bash
git add .

git commit -m "Added Login Feature"
```

---

## Step 7

Push

```bash
git push origin feature/login
```

---

## Step 8

GitHub

Click

```
Create Pull Request
```

Repository owner reviews your changes.

---

# 9. Create a Fork and Create a Pull Request

## Complete Flow

```
Fork Repository
        │
Clone Repository
        │
Create Branch
        │
Write Code
        │
git add
        │
git commit
        │
git push
        │
Open GitHub
        │
Create Pull Request
        │
Review
        │
Merge
```

---

## Commands

```bash
git clone https://github.com/yourname/project.git

cd project

git checkout -b feature/login

git add .

git commit -m "Added Login"

git push origin feature/login
```

Open GitHub

↓

Click

```
Compare & Pull Request
```

---

# 10. Git Fetch vs Git Pull

## Interview Answer

Both `git fetch` and `git pull` download changes from a remote repository.

The difference is:

- **git fetch** downloads changes without modifying the local branch.
- **git pull** downloads the changes and immediately merges them into the current branch.

---

## Git Fetch

```
Remote Repository
        │
        ▼
Downloads Changes
        │
        ▼
Local Repository
        │
Does NOT Merge
```

Command

```bash
git fetch origin
```

---

## Git Pull

```
Remote Repository
        │
        ▼
Downloads Changes
        │
        ▼
Automatically Merge
        │
        ▼
Working Directory Updated
```

Command

```bash
git pull origin main
```

---

## Difference Table

| Git Fetch | Git Pull |
|------------|-----------|
| Downloads only | Downloads + Merge |
| Safe | May create merge conflicts |
| No working directory changes | Updates current branch |
| Used for review | Used to synchronize code |

---

# 11. Show How Git Fetch and Pull Work in Realtime

Suppose

Developer A pushes

```
Login.java
```

Developer B

Current project

```
Home.java
```

---

Developer B

Runs

```bash
git fetch
```

Git downloads changes.

BUT

Current branch remains unchanged.

Check

```bash
git diff main origin/main
```

Now

Developer decides

```bash
git merge origin/main
```

---

Instead

```bash
git pull
```

Git performs

```
git fetch

+

git merge
```

automatically.

---

# 12. Which Command Do You Use Mostly? Git Fetch or Git Pull?

## Interview Answer

In production environments, I prefer **git fetch** because it allows me to review incoming changes before merging them into my local branch. This reduces the risk of unexpected merge conflicts or integrating unstable code.

I use **git pull** when I know the remote branch is stable and I simply want to synchronize my local branch.

---

## Why Fetch?

Advantages

✔ Review changes

✔ Compare branches

✔ Safer

✔ Avoid accidental merge

---

## Commands

```bash
git fetch origin

git diff main origin/main
```

Then

```bash
git merge origin/main
```

---

# 13. Practice Git Fetch vs Git Pull

Repository

```
Developer A
```

Adds

```
Dockerfile
```

Pushes.

Developer B

Runs

```bash
git fetch
```

Verify

```bash
git log origin/main
```

Merge

```bash
git merge origin/main
```

---

Reset

Developer A

Pushes again.

Developer B

Runs

```bash
git pull
```

Working directory updates immediately.

---

# 14. Git Rebase vs Git Merge

## Interview Answer

Both Git Merge and Git Rebase combine changes from one branch into another.

The difference is:

- **Git Merge** preserves branch history by creating a merge commit.
- **Git Rebase** rewrites commit history to create a clean, linear project history.

---

## Git Merge

```
A---B---C main
     \
      D---E feature
             \
              Merge
```

History

```
A

B

C

D

E

Merge Commit
```

---

Command

```bash
git merge feature
```

---

## Git Rebase

```
A---B---C main

        \
         D'

          E'
```

No merge commit.

Cleaner history.

---

Command

```bash
git rebase main
```

---

## Comparison

| Merge | Rebase |
|--------|---------|
| Preserves history | Rewrites history |
| Merge commit created | No merge commit |
| Easy to understand | Cleaner history |
| Safe for shared branches | Best for local branches |

---

# 15. Show Practically How Rebase Differs from Merge

Create branch

```bash
git checkout -b feature
```

Commit

```
Feature 1
```

Switch

```bash
git checkout main
```

Commit

```
Bug Fix
```

---

Merge

```bash
git merge feature
```

Graph

```bash
git log --graph
```

Shows

```
Merge Commit
```

---

Reset.

Now

```bash
git rebase main
```

Graph

```
Straight Line
```

---

# 16. How to Explain Git Merge vs Git Rebase in Interviews

## Good Interview Answer

> Git Merge combines two branches by creating a merge commit and preserving the complete branch history. Git Rebase moves the feature branch commits onto the latest base branch, resulting in a cleaner, linear history. I use Merge for shared branches where preserving history is important, and Rebase for local feature branches before creating a Pull Request to keep the commit history clean.

---

## Production Recommendation

✅ Use **Merge** for:

- Main branch
- Release branch
- Shared branches

✅ Use **Rebase** for:

- Local feature branches
- Cleaning commit history
- Preparing Pull Requests

Avoid rebasing commits that have already been pushed to a shared branch unless the team has agreed to rewrite history.

---

# 17. Git Fork vs Git Clone

| Git Fork | Git Clone |
|-----------|-----------|
| Creates a copy of the repository on GitHub | Creates a local copy on your computer |
| Used when you don't have write access | Used when you have repository access |
| Common in open-source contributions | Common in company projects |
| Requires GitHub | Works with any Git repository |
| Enables Pull Request workflow | Used for daily development |

---

## Interview Tip

One of the most common interview questions is:

**"Why not simply clone instead of fork?"**

A strong answer is:

> "Cloning only creates a local copy of a repository. It does not give me my own remote repository. Forking creates a separate repository under my GitHub account, allowing me to work independently and submit changes back to the original project through a Pull Request."

# 13. Find and List Log Files Older Than 7 Days in /var/log

## Interview Answer

To list log files older than 7 days, I use the `find` command with the `-mtime` option. Before deleting any files in production, I always verify the output to ensure that only the intended files are selected.

---

## Command

```bash
find /var/log -type f -name "*.log" -mtime +7
```

### Explanation

| Option | Description |
|---------|-------------|
| `find` | Search for files/directories |
| `/var/log` | Search location |
| `-type f` | Search only files |
| `-name "*.log"` | Match log files |
| `-mtime +7` | Modified more than 7 days ago |

---

## Sample Output

```
/var/log/nginx/access.log
/var/log/nginx/error.log
/var/log/app/application.log
```

---

## Count Files

```bash
find /var/log -type f -name "*.log" -mtime +7 | wc -l
```

---

## Delete (Only After Verification)

```bash
find /var/log -type f -name "*.log" -mtime +7 -delete
```

---

## Best Practice

Always execute the `find` command without `-delete` first to verify the matching files before removing them.

---

## Production Scenario

A monitoring alert indicates that `/var` usage has reached 90%.

Steps:

1. Identify old logs.
2. Verify they are no longer needed.
3. Compress or archive them.
4. Delete only after confirmation.

---

# 14. Get the List of Users Who Logged in Today

## Interview Answer

Linux maintains login history in the `wtmp` file. Commands such as `last`, `who`, and `w` help identify current and historical login sessions.

---

## Currently Logged-in Users

```bash
who
```

Example

```
ubuntu   pts/0   Jul 2 09:15
ec2-user pts/1   Jul 2 10:42
```

---

## Active Sessions

```bash
w
```

Shows

- User
- Login time
- IP Address
- Running command
- CPU usage

---

## Login History

```bash
last
```

---

## Today's Logins

```bash
last | grep "$(date '+%b %e')"
```

Example

```
ubuntu pts/0 Jul 2 09:15
john   pts/1 Jul 2 10:30
```

---

## If Some Packages Were Deleted

If the `last` command is unavailable or login history is incomplete:

```bash
journalctl | grep "session opened"
```

or

```bash
grep "session opened" /var/log/auth.log
```

(RHEL)

```bash
grep "session opened" /var/log/secure
```

---

## Production Use

Useful for

- Security auditing
- Incident response
- Compliance
- Investigating unauthorized access

---

# 15. Website Doesn't Load. How Will You Investigate?

## Interview Answer

When a website is unavailable, I troubleshoot layer by layer instead of guessing. I verify DNS resolution, network connectivity, web server health, application status, firewall rules, logs, and resource utilization until I identify the root cause.

---

# Step 1 - Verify DNS

```bash
nslookup example.com
```

or

```bash
dig example.com
```

---

# Step 2 - Check Network Connectivity

```bash
ping example.com
```

---

# Step 3 - Verify Web Server

```bash
systemctl status nginx
```

or

```bash
systemctl status httpd
```

---

# Step 4 - Check Listening Ports

```bash
ss -tulnp
```

Look for

```
80
443
```

---

# Step 5 - Test Locally

```bash
curl localhost
```

or

```bash
curl localhost:8080
```

---

# Step 6 - Review Logs

```bash
tail -100 /var/log/nginx/error.log
```

or

```bash
journalctl -u nginx
```

---

# Step 7 - Verify Disk Space

```bash
df -h
```

---

# Step 8 - Check CPU & Memory

```bash
top
```

---

# Step 9 - Verify Firewall

Ubuntu

```bash
sudo ufw status
```

RHEL

```bash
sudo firewall-cmd --list-all
```

---

# Step 10 - Verify AWS Security Group

Ensure

- Port 80 allowed
- Port 443 allowed
- Correct source CIDR

---

## Common Root Causes

- Nginx service stopped
- Backend application crashed
- Database unavailable
- DNS failure
- Firewall blocking traffic
- Security Group misconfiguration
- SSL certificate expired
- Disk full
- High CPU usage
- Memory exhaustion

---

## Production Troubleshooting Flow

```
Website Down
      │
      ▼
DNS
      │
      ▼
Network
      │
      ▼
Nginx
      │
      ▼
Application
      │
      ▼
Database
      │
      ▼
Logs
      │
      ▼
CPU / Memory
      │
      ▼
Firewall
      │
      ▼
Security Group
```

---

# 16. Using sed, Remove the First and Last Line of a File

## Remove First Line

```bash
sed '1d' file.txt
```

---

## Remove Last Line

```bash
sed '$d' file.txt
```

---

## Remove Both First and Last Line

```bash
sed '1d;$d' file.txt
```

---

## Save Changes

```bash
sed -i '1d;$d' file.txt
```

---

## Example

### Input

```
Header
Data1
Data2
Data3
Footer
```

### Command

```bash
sed '1d;$d' file.txt
```

### Output

```
Data1
Data2
Data3
```

---

## Explanation

| Expression | Meaning |
|------------|---------|
| `1d` | Delete first line |
| `$d` | Delete last line |
| `-i` | Modify file in place |

---

## Production Use

Useful for

- Removing CSV headers
- Removing trailers
- Cleaning log files
- Processing reports

---

# 17. What Are the Different Types of Variables in Linux?

## Interview Answer

Variables in Linux store data that can be accessed by the shell or applications. They are mainly categorized as local variables, environment variables, shell variables, positional parameters, special variables, and read-only variables.

---

# 1. Local Variables

Available only in the current shell.

```bash
name="Omkar"

echo $name
```

Output

```
Omkar
```

---

# 2. Environment Variables

Inherited by child processes.

View

```bash
printenv
```

or

```bash
env
```

Example

```bash
echo $HOME

echo $PATH

echo $USER
```

Export

```bash
export PROJECT=DevOps
```

Verify

```bash
echo $PROJECT
```

---

# 3. Shell Variables

Used only inside the current shell unless exported.

```bash
course="Linux"

echo $course
```

---

# 4. Positional Parameters

Passed to shell scripts.

Example

```bash
#!/bin/bash

echo $1
echo $2
```

Run

```bash
bash script.sh AWS Linux
```

Output

```
AWS
Linux
```

---

# 5. Special Variables

| Variable | Description |
|-----------|-------------|
| `$0` | Script name |
| `$1` | First argument |
| `$2` | Second argument |
| `$#` | Number of arguments |
| `$@` | All arguments |
| `$?` | Exit status of previous command |
| `$$` | Current shell PID |
| `$!` | Last background process PID |

Example

```bash
echo $$
```

Output

```
2145
```

---

# 6. Read-Only Variables

Cannot be modified.

```bash
readonly PI=3.14
```

Attempting to change it

```bash
PI=10
```

Produces

```
bash: PI: readonly variable
```

---

# Interview Follow-up Questions

### Difference between Local and Environment Variables?

| Local Variable | Environment Variable |
|----------------|----------------------|
| Available only in current shell | Available to child processes |
| Not inherited | Inherited after `export` |
| Temporary | Used by applications and scripts |

---

# Common Environment Variables

```bash
HOME

PATH

USER

SHELL

PWD

HOSTNAME

LANG
```

View all

```bash
printenv
```

or

```bash
env
```

---
# DevOps Interview Handbook - Part 3A (Git & GitHub)

# 1. How do you combine Multiple Commits into a Single Commit?

## Interview Answer

Git provides a feature called **Interactive Rebase** (`git rebase -i`) that allows multiple commits to be combined into a single commit. This process is called **Squashing Commits**.

Squashing is useful when several small commits belong to the same feature or bug fix. Instead of polluting the Git history with many small commits like "fix typo", "update code", or "final fix", we create one clean, meaningful commit.

---

## Why Squash Commits?

Instead of this history:

```text
a1b2c3 Added Login Page
b2c3d4 Fixed CSS
c3d4e5 Fixed Button
d4e5f6 Removed Debug Code
```

We can create:

```text
e7f8g9 Added Complete Login Module
```

This keeps Git history clean and easier to review.

---

## Practical Example

### Step 1

Check commit history.

```bash
git log --oneline
```

Example

```text
a1b2c3 Added Login Page
b2c3d4 Fixed CSS
c3d4e5 Fixed Button
d4e5f6 Removed Debug Code
```

---

### Step 2

Start Interactive Rebase.

```bash
git rebase -i HEAD~4
```

This opens an editor.

```
pick a1b2c3 Added Login Page
pick b2c3d4 Fixed CSS
pick c3d4e5 Fixed Button
pick d4e5f6 Removed Debug Code
```

---

### Step 3

Keep the first commit as `pick` and change the remaining commits to `squash`.

```
pick a1b2c3 Added Login Page
squash b2c3d4 Fixed CSS
squash c3d4e5 Fixed Button
squash d4e5f6 Removed Debug Code
```

Save and exit.

---

### Step 4

Git opens another editor asking for the final commit message.

Example

```
Added Login Module

- Login UI
- CSS Styling
- Validation
- Bug Fixes
```

Save and exit.

---

### Step 5

Verify

```bash
git log --oneline
```

Output

```
e7f8g9 Added Login Module
```

---

## Production Scenario

Before creating a Pull Request, developers often squash multiple local commits into a single clean commit to make code review easier and maintain a readable project history.

---

## Important Note

If the commits have already been pushed to a shared branch, squashing changes commit history. In that case, coordinate with your team and use:

```bash
git push --force-with-lease
```

instead of `git push --force`.

---

# 2. Explain 10 Git Commands That You Use on a Day-to-Day Basis

## Interview Answer

As a DevOps Engineer, I use Git daily for version control, collaboration, code reviews, and deployments. The commands I use most frequently are:

| Command | Purpose |
|---------|---------|
| `git clone` | Clone repository |
| `git status` | Check repository status |
| `git add` | Stage changes |
| `git commit` | Save changes locally |
| `git push` | Push changes to remote |
| `git pull` | Download and merge changes |
| `git fetch` | Download changes without merging |
| `git branch` | Manage branches |
| `git checkout` / `git switch` | Switch branches |
| `git merge` | Merge branches |

---

## git clone

Downloads the repository.

```bash
git clone https://github.com/company/project.git
```

---

## git status

Shows

- Modified files
- Staged files
- Untracked files

```bash
git status
```

---

## git add

Stage changes.

```bash
git add .
```

or

```bash
git add app.py
```

---

## git commit

Save staged changes locally.

```bash
git commit -m "Added login functionality"
```

---

## git push

Upload commits.

```bash
git push origin main
```

---

## git pull

Fetch + Merge.

```bash
git pull origin main
```

---

## git fetch

Downloads changes only.

```bash
git fetch origin
```

---

## git branch

```bash
git branch
```

Create

```bash
git branch feature/login
```

---

## git checkout

```bash
git checkout feature/login
```

Modern alternative

```bash
git switch feature/login
```

---

## git merge

```bash
git merge feature/login
```

---

## Bonus Commands

```bash
git log --oneline

git stash

git stash pop

git diff

git tag

git remote -v
```

---

# 3. I Want to Ignore Pushing Changes to a File to Git. How Can I Do It?

## Interview Answer

If I never want Git to track a file, I add it to the `.gitignore` file.

If the file is already being tracked, I remove it from Git's index while keeping it locally.

---

## Method 1 – .gitignore

Example

```
logs/

*.log

.env

*.pem
```

Git ignores these files.

---

## Method 2 – Already Tracked File

```bash
git rm --cached .env
```

Commit

```bash
git commit -m "Stop tracking .env"
```

---

## Method 3 – Ignore Local Changes Only

Useful for personal configuration files.

```bash
git update-index --skip-worktree config.yml
```

Undo

```bash
git update-index --no-skip-worktree config.yml
```

---

## Production Scenario

Never commit:

- `.env`
- AWS credentials
- PEM files
- API Keys
- Database passwords
- Kubernetes Secrets

---

# 4. What is the Purpose of the .git Folder?

## Interview Answer

The `.git` directory is the heart of every Git repository. It contains the complete repository metadata, commit history, branches, tags, configuration, objects, and references required for Git to manage version control.

Without the `.git` folder, the project becomes a normal directory and Git commands no longer work.

---

## View Hidden Files

```bash
ls -la
```

Output

```
.git
README.md
src/
pom.xml
```

---

## Important Contents

```
.git/

objects/

refs/

HEAD

config

logs/

hooks/

index
```

---

## Responsibilities

Stores

- Commit history
- Branches
- Tags
- Staging area
- Remote information
- Repository configuration

---

## Production Use

Every Git operation (`commit`, `branch`, `merge`, `rebase`, `checkout`) reads or writes information inside the `.git` directory.

---

# 5. Can You Restore a Deleted .git Folder?

## Interview Answer

No, Git cannot restore a deleted `.git` folder because it contains the repository's entire version history and metadata. If the folder is deleted and no backup exists, the project loses its Git history.

---

## Scenario 1 – Remote Repository Exists

```bash
git clone https://github.com/company/project.git
```

Copy your source files back into the cloned repository.

---

## Scenario 2 – No Remote, No Backup

The project files still exist, but Git history is permanently lost.

Reinitialize Git:

```bash
git init
```

Add remote:

```bash
git remote add origin https://github.com/company/project.git
```

Commit again.

---

## Best Practice

Always push work to GitHub, GitLab, or Bitbucket regularly to avoid losing repository history.

---

# 6. A Teammate Accidentally Committed a Kubernetes Secret (Base64 Encoded) to Git

## Interview Answer

Even though Kubernetes Secrets are Base64 encoded, they are **not encrypted**. Anyone with access to the repository can decode them easily. Therefore, such secrets must be treated as compromised immediately.

---

## Why Is This Dangerous?

Example

```yaml
data:
  password: YWRtaW4xMjM=
```

Decode

```bash
echo "YWRtaW4xMjM=" | base64 -d
```

Output

```
admin123
```

---

## Immediate Response

### 1. Rotate the Secret

Generate a new password, token, or API key.

---

### 2. Remove the Secret from Git History

Use tools such as:

- `git filter-repo` (recommended)
- BFG Repo-Cleaner

Example (using `git filter-repo`):

```bash
git filter-repo --path secret.yaml --invert-paths
```

Force-push the rewritten history only after coordinating with the team.

---

### 3. Update Kubernetes

Create a new Secret.

```bash
kubectl create secret generic app-secret \
  --from-literal=password=NewStrongPassword
```

Restart workloads if necessary so they pick up the new secret.

---

### 4. Prevent Future Incidents

- Add secret files to `.gitignore`.
- Use secret scanning tools (e.g., GitHub Secret Scanning, Gitleaks).
- Store secrets in dedicated secret managers such as:
  - AWS Secrets Manager
  - HashiCorp Vault
  - Kubernetes External Secrets
- Use CI/CD checks to block commits containing secrets.

---

## Interview Tip

Never say:

> "It's okay because it's Base64 encoded."

A strong answer is:

> "Base64 is an encoding mechanism, not encryption. I would immediately rotate the secret, remove it from the repository history, update the Kubernetes Secret, and implement secret-scanning and proper secret management to prevent future exposure."
# Senior Interview Tip

When asked a troubleshooting question, **avoid jumping straight to a solution** such as restarting a service or rebooting the server.

Instead, explain a **structured troubleshooting methodology**:

1. Identify the symptoms.
2. Collect relevant information.
3. Analyze logs and system metrics.
4. Determine the root cause.
5. Implement the appropriate fix.
6. Verify that the issue is resolved.
7. Take preventive measures to avoid recurrence.

This demonstrates a production mindset and is exactly what interviewers expect from a DevOps Engineer.
