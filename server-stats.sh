#!/bin/bash

# Function to display CPU usage
echo "===== CPU Usage ====="
top -bn1 | grep "Cpu(s)" | awk '{print "CPU Usage: " 100 - $8 "%"}'

echo "===== Memory Usage ====="
free -m | awk 'NR==2{printf "Used: %s MB / Total: %s MB (%.2f%%)\n", $3, $2, $3*100/$2 }'

echo "===== Disk Usage ====="
df -h --total | awk '$1 == "total" {print "Used: " $3 " / " $2 " (" $5 " used)"}'

echo "===== Top 5 Processes by CPU Usage ====="
ps -eo pid,comm,%cpu --sort=-%cpu | head -6

echo "===== Top 5 Processes by Memory Usage ====="
ps -eo pid,comm,%mem --sort=-%mem | head -6

# Stretch goal: Additional system stats
echo "===== System Info ====="
echo "OS Version: $(lsb_release -d | cut -f2)"
echo "Uptime: $(uptime -p)"
echo "Load Average: $(uptime | awk -F'load average:' '{print $2}')"
echo "Logged-in Users: $(who | wc -l)"

echo "===== Failed Login Attempts ====="
sudo journalctl _SYSTEMD_UNIT=sshd.service | grep "Failed password" | wc -l
