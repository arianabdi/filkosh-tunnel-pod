FROM ubuntu:16.04

# Update package lists and install openssh-server, curl, and sshpass
RUN apt-get update && \
    apt-get install -y openssh-server curl sshpass && \
    apt-get clean

# Create directory for SSH daemon
RUN mkdir /var/run/sshd

# Set root password for SSH access (change 'your_password' to your desired password)
RUN echo 'root:your_password' | chpasswd

# Allow root login via SSH
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Optional: Update PAM configuration
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# Expose SSH port
EXPOSE 40111

# Start SSH daemon
CMD ["/usr/sbin/sshd", "-D"]
