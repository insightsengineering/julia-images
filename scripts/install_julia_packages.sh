#!/usr/bin/env bash

set -e

# Takes in the destination image name as the first argument.
destination_image_name="$1"

echo "DESTINATION_IMAGE_NAME = $destination_image_name"

if [ "$destination_image_name" == "julia-vscode" ]; then
cat > install_pkgs.jl <<EOT
  using Pkg;
  pkgs=["Distributions", "CSV", "DataFrames", "JSON", "BenchmarkTools"]
  for i in pkgs
    Pkg.add(i)
  end
EOT

elif [ "$destination_image_name" == "julia-vscode" ]; then
cat > install_pkgs.jl <<EOT
  using Pkg;
  pkgs=["Distributions", "CSV", "DataFrames", "JSON", "BenchmarkTools"]
  for i in pkgs
    Pkg.add(i)
  end
EOT
fi

julia install_pkgs.jl
