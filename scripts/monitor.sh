#!/bin/bash

LOG_DIR="$(dirname "$0")/../logs"
LOG_FILE="$LOG_DIR/system-monitor.log"

CPU_THRESHOLD=80
RAM_THRESHOLD=80
DISK_THRESHOLD=80

mkdir -p "$LOG_DIR"

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

echo "====================================" >> "$LOG_FILE"
echo "Server Monitor - $TIMESTAMP" >> "$LOG_FILE"
echo "====================================" >> "$LOG_FILE"

# CPU
CPU_IDLE=$(top -bn1 | awk '/Cpu\(s\)/ {print $8}')
CPU_USAGE=$(awk "BEGIN {print 100 - $CPU_IDLE}")

echo "CPU Usage: ${CPU_USAGE}%" | tee -a "$LOG_FILE"

# RAM
RAM_USAGE=$(free | awk '/Mem:/ {
    printf "%.0f", ($3/$2)*100
}')

echo "RAM Usage: ${RAM_USAGE}%" | tee -a "$LOG_FILE"

# Disk
DISK_USAGE=$(df / | awk 'NR==2 {print $5}' | tr -d '%')

echo "Disk Usage: ${DISK_USAGE}%" | tee -a "$LOG_FILE"

# Nginx
NGINX_STATUS=$(systemctl is-active nginx)

echo "Nginx: $NGINX_STATUS" | tee -a "$LOG_FILE"

# SSH
SSH_STATUS=$(systemctl is-active ssh)

echo "SSH: $SSH_STATUS" | tee -a "$LOG_FILE"

# CPU alert
if (( ${CPU_USAGE%.*} > CPU_THRESHOLD )); then
    echo "WARNING: CPU usage above ${CPU_THRESHOLD}%" | tee -a "$LOG_FILE"
fi

# RAM alert
if (( RAM_USAGE > RAM_THRESHOLD )); then
    echo "WARNING: RAM usage above ${RAM_THRESHOLD}%" | tee -a "$LOG_FILE"
fi

# Disk alert
if (( DISK_USAGE > DISK_THRESHOLD )); then
    echo "WARNING: Disk usage above ${DISK_THRESHOLD}%" | tee -a "$LOG_FILE"
fi

# Nginx recovery
if [ "$NGINX_STATUS" != "active" ]; then

    echo "ALERT: Nginx is down." | tee -a "$LOG_FILE"

    echo "Attempting to restart Nginx..." | tee -a "$LOG_FILE"

    systemctl restart nginx

    if systemctl is-active --quiet nginx; then
        echo "Nginx successfully restarted." | tee -a "$LOG_FILE"
    else
        echo "CRITICAL: Nginx restart failed." | tee -a "$LOG_FILE"
    fi

fi

echo "" >> "$LOG_FILE"
