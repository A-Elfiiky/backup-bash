#!/bin/bash

# Array of required packages
packages=(
  tar
  gzip
  gnupg
  openssh-clients
)

# Function to install packages
install_packages() {
  for package in "${packages[@]}"; do
    if ! yum -q list installed "$package" &>/dev/null; then
      echo "Installing $package..."
      if ! yum -y install "$package"; then
        echo "Error: Failed to install $package."
        exit 1
      fi
      echo "$package installed successfully."
    else
      echo "$package is already installed."
    fi
  done
}

# Check if running as root
if [[ $EUID -ne 0 ]]; then
  echo "Error: This script must be run as root."
  exit 1
fi

# Update the system
echo "Updating the system..."
if ! yum -y update; then
  echo "Error: Failed to update the system."
  exit 1
fi
echo "System updated successfully."

# Install packages
install_packages

echo "All dependencies installed successfully."
