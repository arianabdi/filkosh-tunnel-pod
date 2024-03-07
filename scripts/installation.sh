#!/bin/bash

sudo apt install git

# Install Node.js (if not already installed)
if ! command -v node &>/dev/null; then
  echo "Installing Node.js..."
  curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
  sudo apt-get install -y nodejs
fi

if ! command -v jq &>/dev/null; then
  echo "Installing jq..."
  sudo apt-get install -y jq
fi

if ! command -v lsof &>/dev/null; then
  echo "Installing lsof..."
  sudo apt-get install -y lsof
fi

# Install NestJS CLI (if not already installed)
if ! command -v nest &>/dev/null; then
  echo "Installing NestJS CLI..."
  sudo npm install -g @nestjs/cli
fi


# Install NestJS CLI (if not already installed)
if ! command -v pm2 &>/dev/null; then
  echo "Installing pm2..."
  sudo npm install -g pm2
fi


# Clone your GitHub repository (replace <your-github-repository-url> with your actual repository URL)
echo "Cloning your project..."
git clone "https://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@github.com/arianabdi/filkosh-tunnel-pod"

# Navigate to the project directory
cd filkosh-tunnel-pod
sudo chmod +x ./scripts/reset_ssh_tunnel.sh
sudo chmod +x ./scripts/setup_ssh_tunnel.sh
sudo chmod +x ./scripts/start_ssh_tunnel.sh

# Install project dependencies
echo "Installing node modules..."
npm install --legacy-peer-deps

# Build the NestJS application
echo "Building the NestJS application..."
npm run build

# Start the application using pm2 (assuming pm2 is installed)
echo "Starting the application"
#npm start dist/main.js
pm2 start dist/main.js --name filkosh-tunnel-pod

#start application after server reboot
pm2 startup

echo "Installation completed!"
