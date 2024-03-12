FROM ubuntu:16.04
RUN apt-get update && apt-get install -y openssh-server curl sshpass nano cron
RUN mkdir /var/run/sshd \
    && echo 'root:xx44kksszxz' | chpasswd \
    && sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd



# Create reset_ssh_tunnel.sh script
RUN echo '# Check if SSH tunnel process is running on port 40111\nif ! ps -aux | grep ssh | grep 40111 | grep -v grep > /dev/null; then\n    # SSH tunnel is not running, start the tunnel\n    echo "Starting SSH tunnel..."\n    ssh -f -N -L 0.0.0.0:40111:XXXXXXXXXXXXX:40111 root@XXXXXXXXXXXXX -p40111\n    echo "SSH tunnel started successfully."\nelse\n    echo "SSH tunnel is already running"\nfi' > ~/reset_ssh_tunnel.sh \
    && chmod +x ~/reset_ssh_tunnel.sh

# Add cron job to crontab
RUN echo "*/2 * * * * ~/reset_ssh_tunnel.sh" | crontab -

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

