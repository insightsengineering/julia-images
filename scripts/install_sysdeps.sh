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

# Install security patches
unattended-upgrade -v

# Clean up
apt-get autoremove -y
apt-get autoclean -y
rm -rf /var/lib/apt/lists/* quarto-"${ARCH}".deb

echo "LC_ALL=$LC_ALL" >> /etc/profile
echo "PATH=$PATH" >> /etc/profile
