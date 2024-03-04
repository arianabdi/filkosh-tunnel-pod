# Step 4: Check if SSH tunnel process is running on port 40111
if ! ps -aux | grep ssh | grep 40111 | grep -v grep > /dev/null; then
    # SSH tunnel is not running, start the tunnel
    echo "Starting SSH tunnel..."
    ssh -f -N -L 0.0.0.0:40111:xxx.xxx.xxx.xxx:40111 root@xxx.xxx.xxx.xxx -p40111
    echo "SSH tunnel started successfully."
else
    echo "SSH tunnel is already running."
fi