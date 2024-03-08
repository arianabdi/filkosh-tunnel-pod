# Use Ubuntu as base image
FROM ubuntu:latest

# Update packages and install curl
RUN apt-get update && \
    apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get install -y \
    sshpass \
    openssh-client \
    curl

# Create .ssh directory if it doesn't exist
RUN mkdir -p ~/.ssh

# Generate SSH key if not already exist
RUN if [ ! -f ~/.ssh/id_rsa ]; then \
        ssh-keygen -t rsa -b 4096 -N "" -f ~/.ssh/id_rsa -q; \
    fi
# Set working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json (if exists)
COPY package*.json ./

# Install Node.js dependencies
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g npm@latest && \
    npm install -g @nestjs/cli && \
    npm install

# Copy the entire project directory into the container
COPY . .

# Run the build process
RUN npm run build

# Expose the port the app runs on
# EXPOSE 8080

# Command to run the application
CMD ["npm", "run", "start"]
