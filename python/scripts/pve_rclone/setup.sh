#!/bin/bash

# Script for installing and setting up rclone on Proxmox VE for use with Backblaze B2
# Currently only configured for use with a single bucket
# Tested with rclone v1.60.1-DEV

source .env

echo -e "----- PVE Backblaze B2 rclone Setup -----\n"

echo "This script will:"
echo "1. Install rclone"
echo "2. Install pip"
echo "3. Configure rclone"
echo -e "4. Create a crontab entry to schedule daily backups\n"

echo "Are you want to continue? (y/n)"
read continue

if [ $continue == "n" ]; then
    exit 1
fi


# Install rclone
sudo apt update
sudo apt install rclone
echo -e "rclone installed...\n"

# Install pip
sudo apt install python3-pip -y
echo -e "pip installed...\n"

# Intall venv
sudo apt install python3.13-venv -y
echo -e "venv installed...\n"

# Create and open a venv
python3 -m venv venv
source venv/bin/activate

# Install dotenv
pip install python-dotenv

# Configure rclone
sudo python3 rclone_config.py
echo -e "rclone configured...\n"

# Create log directory for backups
sudo mkdir $LOG_DIR
sudo chown $PVE_USER:$PVE_USER $LOG_DIR

echo -e "\n SUCCESS! You will still need to add an entry to your crontab to schedule the backups \n"


