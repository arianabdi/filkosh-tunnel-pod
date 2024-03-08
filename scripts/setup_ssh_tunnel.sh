#!/bin/bash

# Extract IP address argument
ip_address="$1"
password="$2"

# Step 1: Run ssh-keyscan against the target server to get the public key
ssh-keyscan -p 40111 "$ip_address" >> ~/.ssh/known_hosts

# Step 2: Generate SSH key if not already exist
if [ ! -f ~/.ssh/id_rsa ]; then
    ssh-keygen -t rsa -b 4096 -N "" -f ~/.ssh/id_rsa -q
fi

# Step 3: Append the public key to the known_hosts file
ssh-keyscan -p 40111 "$ip_address" >> ~/.ssh/known_hosts

# Step 2: Send SSH key to target server
echo "yes" | sshpass -p "$password" ssh-copy-id -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null  -i ~/.ssh/id_rsa.pub -p 40111 root@"$ip_address"

# Step 3: Create SSH tunnel to target server
ssh -f -N -L 0.0.0.0:40111:"$ip_address":40111 root@"$ip_address" -p40111

## Step 4: Make reset_ssh_tunnel.sh executable
#chmod +x reset_ssh_tunnel.sh
#
## Step 5: Add cron job to reset SSH tunnel every 5 minutes
#(crontab -l ; echo "*/5 * * * * /path/to/reset_ssh_tunnel.sh") | crontab -
