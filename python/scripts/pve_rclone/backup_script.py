#!/usr/bin/env python3

import os
import subprocess
from dotenv import load_dotenv
from datetime import date

# Load in env variables
load_dotenv()
backup_dir = os.getenv("LOCAL_BACKUP_DIR")
bucket_name = os.getenv("B2_BUCKET_NAME")
log_dir = os.getenv("LOG_DIR")
dest_dir = f"backblaze_b2:{bucket_name}"

# Perform the sync
log = subprocess.run(['rclone', 'sync', '/var/lib/vz/dump', dest_dir, '--progress'], 
               capture_output=True, 
               text=True, 
               check=True).stdout

# Write the log
today = date.today()
timestamp = f"{today.month}_{today.day}_{today.year}"
log_name = f"b2_backup_{timestamp}.log"
log_path = os.path.join(log_dir, log_name)
with open(log_path, 'w') as file:
    file.write(log)