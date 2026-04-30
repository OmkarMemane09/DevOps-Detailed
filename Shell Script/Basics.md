# Shell Scripting Basics

##  Shell vs Terminal vs Console

### Shell
- A **shell** is a command interpreter.
- It takes user commands and passes them to the operating system kernel.
- Example: `bash`, `sh`, `zsh`

### Terminal
- A **terminal** is a program that provides an interface to interact with the shell.
- Example: GNOME Terminal, xterm

### Console
- A **console** is a physical or virtual device used to interact with the system.
- Earlier: Physical keyboard + monitor
- Now: Virtual consoles in OS

---

##  Types of Shells in Linux

| Shell | Description |
|------|------------|
| sh (Bourne Shell) | Oldest shell, basic scripting |
| bash (Bourne Again Shell) | Most commonly used shell |
| zsh (Z Shell) | Advanced features, customization |
| ksh (Korn Shell) | Used in enterprise environments |
| csh (C Shell) | C-like syntax |

---

##  Shell Functions

Functions allow reuse of code in scripts.

### Syntax:
```bash
function_name() {
    commands
}
Example:
greet() {
    echo "Hello, Omkar"
}

greet

```
##  How to Switch Shell

### Check current shell:
```bash
echo $SHELL
```
### List available shells:
```bash
cat /etc/shells
```

### Change shell:
```bash
chsh -s /bin/zsh
```

###  Advantages of Shell

**Automates repetitive tasks**

**Saves time and effort**

**Easy to write and execute**

**Direct interaction with OS**

**Useful for DevOps, automation, deployments**

### What is Shell Script?

A shell script is a file containing a series of commands executed by the shell.

Example:
```bash
#!/bin/bash
echo "This is my first script"
```

## Shebang (#!)
The first line in a script
Tells the system which interpreter to use

Example:
```bash
#!/bin/bash
```
*Other examples:*
```bash
#!/bin/sh
#!/usr/bin/env bash
```

##  How to Run a Script

**Step 1: Create file**
nano script.sh

**Step 2: Add code**
#!/bin/bash
echo "Hello World"

**Step 3: Make executable**

chmod +x script.sh
Step 4: Run script
./script.sh

**Ways to Run a Script**

#### Method 1: Using bash
```bash
bash script.sh
```
#### Method 2: Using sh
```bash
sh script.sh
```
#### Method 3: Direct execution
```bash
./script.sh
```
#### Method 4: Source script
```bash
source script.sh
```
OR
```bash
. script.sh
```


##  Key Notes
Always use shebang for portability
Give execute permission before running
Use functions to make scripts modular
Prefer bash for modern scripting
