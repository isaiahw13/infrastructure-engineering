#!/usr/bin/env python3

import os
from dotenv import load_dotenv

# Load in env varaiables for B2 rclone config
load_dotenv()
user = os.getenv("PVE_USER")
b2_key_id = os.getenv("B2_APPLICATION_KEY_ID")
b2_key = os.getenv("B2_APPLICATION_KEY")
hard_del = os.getenv("HARD_DELETE")
log_dir = os.getenv("LOG_DIR")

# Create config directory for rclone
config_dir = f"/home/{user}/.config/rclone/"
config_name = "rclone.conf"
config_path = os.path.join(config_dir, config_name)
os.makedirs(config_dir, exist_ok=True)
print(f"Config directory created at {config_dir}")

# Create config file
try:
    with open(config_path, 'w') as file:
        print(f"Config file {config_name} created at {config_dir}")
        file.write("[backblaze_b2]\n")
        file.write("type = b2\n")
        file.write(f"account = {b2_key_id}\n")
        file.write(f"key = {b2_key}\n")
        file.write(f"hard_delete = {hard_del}\n")
except IOError as e:
    print(f"Error creating file: {e}")
