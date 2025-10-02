#!/bin/bash

echo ---------------------------------------
echo "         System Health Report         "
echo ---------------------------------------
echo "Date: $( date )"
echo -e "Uptime: $( uptime -p ) \n"

# Collect Resource Usage Stats
top_output=$(top -b -d1 -n1)

# Display CPU Usage %
idle_percentage=$(echo "$top_output" | grep -i "%Cpu(s)" | cut -c 36-40)
cpu_usage=$(echo "100-$idle_percentage" | bc)
echo "CPU Usage: ${cpu_usage}%"

# Display Memory Usage
total_mib_mem=$(echo "$top_output" | grep -i "MiB Mem" | cut -c 10-18)
total_gib_mem=$(echo "scale=4; $total_mib_mem/1024" | bc)
used_mib_mem=$(echo "$top_output" | grep -i "MiB Mem" | cut -c 41-50)
used_gib_mem=$(echo "scale=4; $used_mib_mem/1024" | bc)
used_mem_percent=$(echo "scale=4; ($used_mib_mem / $total_mib_mem) * 100" | bc)
printf "Memory Usage: %.1fG / %.1fG (%.1f%%) \n" "$used_gib_mem" "$total_gib_mem" "$used_mem_percent"

# Display Disk Space
root_disk_size=$(df -h / | sed 1d | cut -c 15-19 | tr -d '[:space:]') 
root_disk_used=$(df -h / | sed 1d | cut -c 21-25 | tr -d '[:space:]')
root_disk_used_percentage=$(echo "scale=4; ($root_disk_used / $root_disk_size) * 100" | bc)
printf "Disk Space (/): %.1fG / %.1fG (%.1f%%) \n" "$root_disk_used" "$root_disk_size" "$root_disk_used_percentage"

# Display Running Processes
num_processes=$(ps -e --no-headers | wc -l)
echo "Running Processes: ${num_processes}"
echo ---------------------------------------