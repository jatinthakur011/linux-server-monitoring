# Linux Server Monitoring & Auto-Recovery

A Bash-based Linux server monitoring and auto-recovery system that monitors critical system resources and services, records health information in logs, and automatically attempts to recover a failed Nginx service.

---

## 📌 Project Overview

In a production environment, deploying a Linux server is not enough. Servers must also be continuously monitored to detect resource exhaustion and service failures.

This project simulates a basic Linux server operations and monitoring system.

The monitoring script checks:

- CPU usage
- RAM usage
- Disk usage
- Nginx service status
- SSH service status
- Server health information
- Service failures

When Nginx is found to be inactive, the script automatically attempts to restart the service and records the recovery result in the monitoring log.

The monitoring script is scheduled using Cron, allowing the server to be checked automatically at regular intervals.

---

## 🎯 Why This Project Was Built

The main objective was to move beyond basic Linux server configuration and demonstrate practical server monitoring, troubleshooting, automation, and recovery.

A server can be correctly configured and secured but still fail later. For example:

```text
Nginx Running
     ↓
Server Failure / Service Crash
     ↓
Nginx Becomes Inactive
     ↓
Users Cannot Access Website
```

Manually checking the server continuously is not practical. This project introduces an automated approach:

```text
Server
   ↓
Monitor
   ↓
Detect Problem
   ↓
Log Problem
   ↓
Recover Service
   ↓
Verify Recovery
```

---

## 💡 Importance of the Project

This project demonstrates an important DevOps principle:

> Infrastructure should not only be deployed; it should also be monitored and operated reliably.

The project helps demonstrate practical knowledge of:

- Linux system administration
- Bash scripting
- Process and service management
- `systemctl`
- CPU monitoring
- Memory monitoring
- Disk monitoring
- Nginx
- SSH
- Cron jobs
- Log management
- Failure detection
- Automatic service recovery
- Troubleshooting
- Basic operational automation

These concepts are relevant to:

- Linux Administrator
- Cloud Support Engineer
- Cloud Engineer
- Junior DevOps Engineer
- DevOps Intern
- Infrastructure Engineer
- SRE Intern

---

## 🏗️ Architecture

```text
                 Linux EC2 Server
                       │
                       ↓
                    Cron Job
                  Every 5 Minutes
                       │
                       ↓
                  monitor.sh
                       │
        ┌──────────────┼──────────────┐
        ↓              ↓              ↓
       CPU            RAM            Disk
        │              │              │
        └──────────────┼──────────────┘
                       ↓
                Service Monitoring
                       │
                 ┌─────┴─────┐
                 ↓           ↓
              Nginx         SSH
                 │           │
                 ↓           ↓
              Active       Active
                 │
                 │
             If Failed
                 ↓
          Restart Nginx
                 ↓
          Verify Recovery
                 ↓
          monitoring.log
```

---

## 🛠️ Technologies Used

| Technology       | Purpose                              |
|-------------------|---------------------------------------|
| Ubuntu Linux      | Server operating system               |
| AWS EC2           | Cloud server/lab environment          |
| Bash              | Monitoring automation                 |
| Nginx             | Web service monitored by the system   |
| systemd/systemctl | Service management                    |
| Cron              | Scheduled monitoring                  |
| awk               | Resource calculation                  |
| df                | Disk monitoring                       |
| free              | Memory monitoring                     |
| uptime            | Server uptime information             |
| Git/GitHub        | Version control and project documentation |

---

## 📁 Project Structure

```text
linux-server-monitoring/
│
├── scripts/
│   ├── monitor.sh
│   └── system-report.sh
│
├── logs/
│   └── system-monitor.log
│
├── screenshots/
│
├── README.md
└── .gitignore
```

---

## 🔍 Main Components

### 1. `monitor.sh`

The main monitoring script.

It checks:

```text
CPU
RAM
Disk
Nginx
SSH
```

It writes monitoring information to:

```text
logs/system-monitor.log
```

Example:

```text
====================================
Server Monitor - 2026-09-10 07:23:59
====================================
CPU Usage: XX%
RAM Usage: 35%
Disk Usage: 40%
Nginx: active
SSH: active
```

### 2. `system-report.sh`

Generates a detailed Linux server health report.

The report includes:

- Hostname
- IP address
- Uptime
- CPU load
- Memory information
- Disk usage
- SSH status
- Nginx status
- Firewall status

Example:

```text
==========================================
          LINUX SERVER REPORT
==========================================

Hostname       : EC2 Ubuntu Server
IP Address     : Private EC2 IP
Uptime         : Server uptime
CPU Load       : System load

Memory:
               total        used        free
Mem:           ...

Disk:
Filesystem      Size  Used Avail Use%
/dev/root       ...

Services
------------------------------------------
SSH            : active
Nginx          : active

Firewall
------------------------------------------
Status: active

==========================================
          REPORT COMPLETE
==========================================
```

---

## 🔄 Auto-Recovery

One of the most important features of the project is automatic Nginx recovery.

The monitoring script checks:

```bash
systemctl is-active nginx
```

If Nginx is inactive:

```text
Nginx: inactive
       ↓
ALERT: Nginx is down
       ↓
Attempt to restart Nginx
       ↓
Verify service
       ↓
Nginx successfully restarted
```

This demonstrates a basic self-healing infrastructure concept.

---

## 🧪 Failure Testing

To test the recovery mechanism, Nginx was intentionally stopped:

```bash
sudo systemctl stop nginx
```

The service was then checked:

```bash
systemctl is-active nginx
```

Result:

```text
inactive
```

The monitoring script was executed:

```bash
sudo ./scripts/monitor.sh
```

The script detected the failure and attempted recovery.

Result:

```text
Nginx: inactive
SSH: active

ALERT: Nginx is down.
Attempting to restart Nginx...
Nginx successfully restarted.
```

The service was then verified:

```bash
systemctl is-active nginx
```

Result:

```text
active
```

### Recovery flow

```text
Intentional Nginx Failure
          ↓
Monitoring Script
          ↓
Failure Detected
          ↓
Alert Logged
          ↓
Nginx Restart
          ↓
Recovery Verification
          ↓
Nginx Active
```

---

## ⏰ Automated Monitoring with Cron

Cron was configured to execute the monitoring script every five minutes.

Cron configuration:

```text
*/5 * * * * /home/ubuntu/linux-server-monitoring/scripts/monitor.sh
```

Meaning: run the monitoring script every 5 minutes.

The configured job can be checked using:

```bash
crontab -l
```

The Cron service can be checked using:

```bash
systemctl status cron
```

This removes the need to manually execute the monitoring script.

---

## 📊 Example Monitoring Data

Example server monitoring output:

```text
CPU Usage: XX%
RAM Usage: 35%
Disk Usage: 40%
Nginx: active
SSH: active
```

The system records this information in:

```text
logs/system-monitor.log
```

Logs can be viewed with:

```bash
cat logs/system-monitor.log
```

or:

```bash
tail -f logs/system-monitor.log
```

---

## 🚀 How to Run

Clone the repository:

```bash
git clone https://github.com/YOUR_USERNAME/linux-server-monitoring.git
```

Enter the project:

```bash
cd linux-server-monitoring
```

Make scripts executable:

```bash
chmod +x scripts/*.sh
```

Run the monitoring script:

```bash
sudo ./scripts/monitor.sh
```

Generate a server report:

```bash
sudo ./scripts/system-report.sh
```

View monitoring logs:

```bash
cat logs/system-monitor.log
```

---

## 🔐 Security Considerations

The project follows several basic security practices:

- No private SSH keys are stored in the repository.
- Sensitive credentials should never be committed.
- `.pem` and private key files should be excluded using `.gitignore`.
- Firewall status is included in the system report.
- Service management uses Linux `systemctl`.
- Logs are separated from executable scripts.

For production use, monitoring credentials and secrets should be managed using dedicated secret-management systems rather than hardcoded values.

---

## 📈 Future Improvements

This project currently provides basic Bash-based monitoring and recovery. A production-grade implementation could be improved by adding:

**Monitoring**
- Prometheus
- Grafana
- AWS CloudWatch
- Node Exporter

**Alerting**
- Email alerts
- Slack notifications
- Microsoft Teams
- PagerDuty

**Automation**
- Ansible
- Terraform
- CI/CD integration

**Logging**
- Centralized logging
- ELK Stack
- AWS CloudWatch Logs

**Reliability**
- Multiple service recovery policies
- Health-check endpoints
- Retry mechanisms
- Better error handling
- Log rotation

**Cloud Integration**

```text
AWS EC2
   ↓
CloudWatch
   ↓
Metrics
   ↓
Alarms
   ↓
SNS
   ↓
Notification
```

---

## 🧠 What I Learned

Through this project I practiced:

- Linux server monitoring
- Bash automation
- CPU/RAM/disk monitoring
- Linux service management
- Nginx troubleshooting
- Cron scheduling
- Log management
- Failure simulation
- Automatic service recovery
- Operational troubleshooting
- Basic self-healing infrastructure concepts

The project also helped me understand that DevOps is not only about deploying applications. It also involves monitoring, reliability, troubleshooting, automation, and recovery.

---




