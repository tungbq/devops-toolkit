#!/bin/bash

CONFIG_DIR=/config

# Function to create symlink if source exists
create_symlink() {
    local src=$1
    local dest=$2
    if [ -e "$src" ]; then
        ln -sf "$src" "$dest"
        echo "Symlink created: $src -> $dest"
    fi
}

# Check if the /config directory exists and is not empty
if [ -d "$CONFIG_DIR" ] ; then
    echo "Custom configuration directory detected. Setting up symlinks..."

    # TODO: Check and only create if folder does not exist
    # mkdir -p /root/.aws /root/.azure /root/.kube /root/.terraform.d/plugins /root/.config/helm /root/.ansible
    mkdir -p /config/.aws \
             /config/.azure \
             /config/.kube \
             /config/.terraform.d/ \
             /config/.config/helm \
             /config/.ansible

    create_symlink "$CONFIG_DIR/.aws" "/root/.aws"
    create_symlink "$CONFIG_DIR/.azure" "/root/.azure"
    create_symlink "$CONFIG_DIR/.kube" "/root/.kube"
    create_symlink "$CONFIG_DIR/.terraform.d/" "/root/.terraform.d/"
    create_symlink "$CONFIG_DIR/.helm" "/root/.config/helm"
    create_symlink "$CONFIG_DIR/.ansible" "/root/.ansible"
    create_symlink "$CONFIG_DIR/.gitconfig" "/root/.gitconfig"
else
    echo "No custom configuration directory detected. Using default configurations..."
fi

# Execute the provided command
exec "$@"
