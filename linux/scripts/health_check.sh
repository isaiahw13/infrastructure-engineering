#!/bin/bash

DISK_USAGE_THRESHOLD=80
# Collect Resource Usage Stats
top_output=$(top -b -d1 -n1)
cpu_usage=$(echo "$top_output" | awk '/%Cpu/ {print 100 - $8}')
total_mib_mem=$(echo "$top_output" | awk '/MiB Mem/ {print $4}')
total_gib_mem=$(echo "scale=4; $total_mib_mem/1024" | bc)
used_mib_mem=$(echo "$top_output" | awk '/MiB Mem/ {print $8}')
used_gib_mem=$(echo "scale=4; $used_mib_mem/1024" | bc)
used_mem_percent=$(echo "scale=4; ($used_mib_mem / $total_mib_mem) * 100" | bc)
root_disk_size=$(df -h / | grep -v Filesystem | awk '{print substr($2, 1, length($2)-1)}') 
root_disk_used=$(df -h / | grep -v Filesystem | awk '{print substr($3, 1, length($3)-1)}')
root_disk_used_percentage=$(echo "scale=4; ($root_disk_used / $root_disk_size) * 100" | bc)
num_processes=$(ps -e --no-headers | wc -l)

echo ---------------------------------------
echo "         System Health Report         "
echo ---------------------------------------
echo "Date: $( date )"
echo -e "Uptime: $( uptime -p ) \n"

# Display CPU Usage %
echo "CPU Usage: ${cpu_usage}%"

# Display Memory Usage
printf "Memory Usage: %.1fG / %.1fG (%.1f%%) \n" "$used_gib_mem" "$total_gib_mem" "$used_mem_percent"

# Display Disk Space
disk_usage_status="OK"
if (( $(echo "$root_disk_used_percentage > $DISK_USAGE_THRESHOLD" | bc -l) ))
then
    disk_usage_status="WARNING: High Disk Usage!"
fi
printf "Disk Space (/): %.1fG / %.1fG (%.1f%%) - %s \n" "$root_disk_used" "$root_disk_size" "$root_disk_used_percentage" "$disk_usage_status"

# Display Running Processes
echo "Running Processes: ${num_processes}"
echo ---------------------------------------