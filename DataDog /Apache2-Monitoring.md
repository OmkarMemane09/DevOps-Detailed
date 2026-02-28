# Datadog Setup & Apache Log Monitoring on Ubuntu

This guide explains how to install the Datadog Agent on an Ubuntu server, configure Apache log monitoring, and visualize metrics and logs in Datadog.

---

## Prerequisites

* Ubuntu server with Apache installed
* Datadog account and API key
* `sudo` privileges on the server

---

## Step 1: Install Datadog Agent

Set your Datadog API key:

```bash
DD_API_KEY=<your_api_key_here>
```

Install the Agent:

```bash
DD_AGENT_MAJOR_VERSION=7 DD_API_KEY=$DD_API_KEY DD_SITE="datadoghq.com" \
bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script.sh)"
```

> Replace `DD_SITE` with your Datadog site if not US (e.g., `datadoghq.eu`, `datadoghq.in`).

Verify installation:

```bash
sudo datadog-agent version
```

---

## Step 2: Enable Log Collection

Edit the main Datadog configuration:

```bash
sudo nano /etc/datadog-agent/datadog.yaml
```

Enable logs by adding:

```yaml
logs_enabled: true
```

Save and exit.

---

## Step 3: Configure Apache Integration

Copy the example configuration:

```bash
sudo cp /etc/datadog-agent/conf.d/apache.d/conf.yaml.example /etc/datadog-agent/conf.d/apache.d/conf.yaml
```

Edit the configuration:

```bash
sudo nano /etc/datadog-agent/conf.d/apache.d/conf.yaml
```

Add the following content:

```yaml
init_config:

instances:
  - apache_status_url: http://localhost/server-status?auto
    tags:
      - service:apache

logs:
  - type: file
    path: /var/log/apache2/access.log
    service: apache
    source: apache
    sourcecategory: http_access

  - type: file
    path: /var/log/apache2/error.log
    service: apache
    source: apache
    sourcecategory: http_error
```

---

## Step 4: Enable Apache Status Page

Enable the status module:

```bash
sudo a2enmod status
```

Edit the status configuration:

```bash
sudo nano /etc/apache2/mods-enabled/status.conf
```

Add or ensure the following:

```apache
<Location /server-status>
    SetHandler server-status
    Require local
</Location>
```

Restart Apache:

```bash
sudo systemctl restart apache2
```

Test the status page:

```bash
curl http://localhost/server-status?auto
```

> You should see plain text Apache metrics.

---

## Step 5: Fix Log Permissions

Apache logs are owned by `root:adm`, while Datadog Agent runs as `dd-agent`.

Add the Datadog agent user to the `adm` group:

```bash
sudo usermod -a -G adm dd-agent
```

Restart the Datadog Agent:

```bash
sudo systemctl restart datadog-agent
```

---

## Step 6: Verify Agent Status

```bash
sudo systemctl status datadog-agent
sudo datadog-agent status
```

You should see:

* Apache metrics under **Running Checks**
* Logs status: **OK**, bytes read > 0

---

## Step 7: Confirm Logs in Datadog

1. Navigate to **Datadog → Logs → Live Tail**
2. Filter by:

```text
service:apache
```

3. You should see `access.log` and `error.log` lines in real-time.
