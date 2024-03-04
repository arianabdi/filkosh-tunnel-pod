#!/bin/bash

# Step 1: Generate SSH key
ssh-keygen -t rsa -b 4096

# Step 2: Send SSH key to target server
ssh-copy-id -i ~/.ssh/id_rsa.pub -p 40111 root@xxx.xxx.xxx.xxx

# Step 3: Create SSH tunnel to target server
ssh -f -N -L 0.0.0.0:40111:xxx.xxx.xxx.xxx:40111 root@xxx.xxx.xxx.xxx -p40111

# Step 4: Make reset_ssh_tunnel.sh executable
chmod +x reset_ssh_tunnel.sh

# Step 5: Add cron job to reset SSH tunnel every 5 minutes
(crontab -e ; echo "*/5 * * * * /path/to/reset_ssh_tunnel.sh") | crontab -

