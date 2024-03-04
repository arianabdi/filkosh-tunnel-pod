#!/bin/bash

# Check if SSH tunnel process is running on port 40111
pid=$(ps -aux | grep ssh | grep 40111 | grep -v grep | awk '{print $2}')

if [ -z "$pid" ]; then
    echo "SSH tunnel process is not running."
else
    echo "PID of SSH tunnel process: $pid"
fi