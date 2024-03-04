#!/bin/bash

# Check if SSH tunnel process is running on port 40111
if ps -aux | grep ssh | grep 40111 | grep -v grep > /dev/null; then
    # SSH tunnel process exists, kill the process
    echo "Killing existing SSH tunnel process..."
    pid=$(ps -aux | grep ssh | grep 40111 | grep -v grep | awk '{print $2}')
    kill -9 $pid
    echo "Existing SSH tunnel process killed."
fi

# Start new SSH tunnel
echo "Starting new SSH tunnel..."
ssh -f -N -L 0.0.0.0:40111:xxx.xxx.xxx.xxx:40111 root@xxx.xxx.xxx.xxx -p40111
echo "New SSH tunnel started successfully."