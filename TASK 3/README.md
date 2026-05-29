# Task 3: Container Monitoring with Cron Job

## Objective
Create a monitoring script to capture container CPU and memory usage with timestamps, automate it using a cron job that runs every 2 minutes, and store logs in `/opt/container-monitor/logs/`.

---

## Environment
- OS: CentOS Stream 9
- Container Name: webcon
- Log Directory: /opt/container-monitor/logs/
- Script Location: /opt/container-monitor/monitor.sh
- Cron Interval: Every 2 minutes

---

## Steps Executed

### 1. Create Monitoring Directory
```bash
sudo mkdir -p /opt/container-monitor/logs
```

### 2. Create Monitoring Script
```bash
sudo vi /opt/container-monitor/monitor.sh
```

### 3. Make Script Executable
```bash
sudo chmod +x /opt/container-monitor/monitor.sh
```

### 4. Test Script Manually
```bash
sudo bash /opt/container-monitor/monitor.sh
```

### 5. Set Up Cron Job
```bash
sudo crontab -e
```
Added line:
```bash
*/2 * * * * /opt/container-monitor/monitor.sh
```

### 6. Enable Cron Service
```bash
sudo systemctl enable --now crond
sudo systemctl status crond
```

### 7. Verify Logs Being Generated
```bash
ls /opt/container-monitor/logs/
cat /opt/container-monitor/logs/monitor_2026-05-28.log
```

---

## Monitoring Script

**File:** `/opt/container-monitor/monitor.sh`

```bash
#!/bin/bash

# Variables
CONTAINER_NAME="webcon"
LOG_DIR="/opt/container-monitor/logs"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
LOG_FILE="$LOG_DIR/monitor_$(date '+%Y-%m-%d').log"

# Get CPU and Memory usage
STATS=$(docker stats --no-stream --format \
"CPU:{{.CPUPerc}} MEM:{{.MemUsage}}" \
$CONTAINER_NAME)

# Append to log
echo "[$TIMESTAMP] $STATS" >> $LOG_FILE
```

---

## Verification Commands
```bash
# Check cron job exists
sudo crontab -l

# logs in real time
sudo cat /opt/container-monitor/logs/monitor_2026-05-28.log
```

---

## Log Output
```
[2026-05-28 05:00:01] CPU:0.00% MEM:3.594MiB/1.636GiB
[2026-05-28 05:02:01] CPU:0.00% MEM:3.594MiB/1.636GiB

```
---

## Expected Outcome
✅ Automatic container monitoring with CPU, memory usage and timestamps logged every 2 minutes.
