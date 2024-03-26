#!/usr/bin/env bash

set -e

# Takes in the destination image name as the first argument.
destination_image_name="$1"

echo "DESTINATION_IMAGE_NAME = $destination_image_name"

declare -A pkgs_to_install

shared_deps="\
wget \
unattended-upgrades \
"

pkgs_to_install["julia"]="${shared_deps}"

pkgs_to_install["julia-vscode"]="${shared_deps} \
curl \
ssh \
git \
vim \
less \
nano \
"

export DEBIAN_FRONTEND=noninteractive
export ACCEPT_EULA=Y
apt-get update -y
apt-get install -y -q ${shared_deps}
apt-get install -y ${pkgs_to_install["${destination_image_name}"]}

# Install quarto
ARCH=$(dpkg --print-architecture)
QUARTO_DL_URL=$(wget -qO- https://api.github.com/repos/quarto-dev/quarto-cli/releases/latest | grep -oP "(?<=\"browser_download_url\":\s\")https.*${ARCH}\.deb")
wget -q "${QUARTO_DL_URL}" -O quarto-"${ARCH}".deb
dpkg -i quarto-"${ARCH}".deb
quarto check install

if [ "$destination_image_name" == "julia-vscode" ]; then
  # Install VS Code server.
  wget --no-check-certificate https://code-server.dev/install.sh -O - | sh
  cp /init-vscode /init
fi

# Install security patches
unattended-upgrade -v

# Clean up
apt-get autoremove -y
apt-get autoclean -y
rm -rf /var/lib/apt/lists/* quarto-"${ARCH}".deb

echo "LC_ALL=$LC_ALL" >> /etc/profile
echo "PATH=$PATH" >> /etc/profile

# Set default initializer if unavailable
if [ ! -f /init ]
then {
    echo "#!/bin/bash" > /init
    chmod +x /init
}
fi
