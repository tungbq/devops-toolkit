#!/bin/bash

# NOTE: 'dtc' stands for devops toolkit configuration
CONFIG_DIR=/dtc

# Function to create symlink if source exists
create_symlink() {
  local src=$1
  local dest=$2
  if [ -e "$src" ]; then
    ln -sf "$src" "$dest"
    echo "Symlink created: $src -> $dest"
  fi
}

# Check if the /dtc directory exists and is not empty
if [ -d "$CONFIG_DIR" ]; then
  echo "Custom configuration directory detected. Setting up symlinks..."

  # TODO: Check and only create if folder does not exist
  ## config mount point
  mkdir -p /dtc/.aws \
    /dtc/.azure \
    /dtc/.kube \
    /dtc/.terraform.d \
    /dtc/.config/helm \
    /dtc/.ansible

  ## root container path
  mkdir -p /root/.config/

  create_symlink "$CONFIG_DIR/.aws" "/root/.aws"
  create_symlink "$CONFIG_DIR/.azure" "/root/.azure"
  create_symlink "$CONFIG_DIR/.kube" "/root/.kube"
  create_symlink "$CONFIG_DIR/.terraform.d" "/root/.terraform.d"
  create_symlink "$CONFIG_DIR/.config/helm" "/root/.config/helm"
  create_symlink "$CONFIG_DIR/.ansible" "/root/.ansible"
  create_symlink "$CONFIG_DIR/.gitconfig" "/root/.gitconfig"
else
  echo "No custom configuration directory detected. Using default configurations..."
fi

# Execute the provided command
exec "$@"
