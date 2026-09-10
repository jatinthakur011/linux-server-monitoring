#!/bin/bash

echo "=========================================="
echo "          LINUX SERVER REPORT"
echo "=========================================="

echo ""

echo "Hostname       : $(hostname)"

echo "IP Address     : $(hostname -I | awk '{print $1}')"

echo "Uptime         : $(uptime -p)"

echo "CPU Load       : $(uptime | awk -F'load average:' '{print $2}')"

echo "Memory:"
free -h

echo ""

echo "Disk:"
df -h /

echo ""

echo "Services"
echo "------------------------------------------"

echo "SSH            : $(systemctl is-active ssh)"

echo "Nginx          : $(systemctl is-active nginx)"

echo ""

echo "Firewall"
echo "------------------------------------------"

sudo ufw status | head -n 1

echo ""

echo "=========================================="
echo "          REPORT COMPLETE"
echo "=========================================="
