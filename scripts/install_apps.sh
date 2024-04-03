#!/usr/bin/env bash

set -e

# Takes in the destination image name as the first argument.
destination_image_name="$1"

echo "DESTINATION_IMAGE_NAME = $destination_image_name"

# List of VS Code Server extensions.
declare -a extension_list=(
  "julialang.language-julia"
)

# Install quarto
ARCH=$(dpkg --print-architecture)
QUARTO_DL_URL=$(wget -qO- https://api.github.com/repos/quarto-dev/quarto-cli/releases/latest | grep -oP "(?<=\"browser_download_url\":\s\")https.*${ARCH}\.deb")
wget -q "${QUARTO_DL_URL}" -O quarto-"${ARCH}".deb
dpkg -i quarto-"${ARCH}".deb
quarto check install

if [ "$destination_image_name" == "julia-vscode" ]; then
  # Install VS Code server.
  echo "Installing Code Server..."
  wget --no-check-certificate https://code-server.dev/install.sh -O - | sh
  echo "Installing Code Server extensions..."
  for extension_name in "${extension_list[@]}"
  do
    code-server --install-extension $extension_name
  done
  cp /init-vscode /init
fi

# Set default initializer if unavailable
if [ ! -f /init ]
then {
    echo "#!/bin/bash" > /init
    echo "julia" >> /init
    chmod +x /init
}
fi
