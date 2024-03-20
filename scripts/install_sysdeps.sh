#!/usr/bin/env bash

set -e

# Takes in the distribution as the first argument.
distribution="$1"

echo "Distribution = $distribution"

mkdir /root/.config
apt-get update
apt-get install -y sudo git wget htop
apt-get clean
apt-get autoremove -y
rm -rf /var/lib/apt/lists/*
echo "DEBIAN_FRONTEND=$DEBIAN_FRONTEND" >> /etc/profile
echo "LC_ALL=$LC_ALL" >> /etc/profile
echo "PATH=$PATH" >> /etc/profile

if [ "$distribution" == "julia-vscode" ]; then
  # Install VS Code server.
  wget --no-check-certificate https://code-server.dev/install.sh -O - | sh
fi
