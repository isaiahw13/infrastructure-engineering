# System Health Check Script

A simple Bash script that provides a health and resource usage report for a Linux system.

## Sample Output
```bash
---------------------------------------
         System Health Report
---------------------------------------
Date: Thu Oct  2 09:32:28 PM PDT 2025
Uptime: up 1 day, 6 hours, 15 minutes

CPU Usage: 6.5%
Memory Usage: 70.0G / 94.1G (74.4%)
Disk Space (/): 8.0G / 2907.0G (0.3%) - OK
Running Processes: 838
---------------------------------------
```

## Usage
1. Make the script executable:
   ```bash
   chmod +x health_check.sh
   ```
2. Run the script:
   ```bash
   ./health_check.sh
   ```
