#!/bin/bash

# Function to print success messages in green
print_success() {
  echo -e "\e[32m$1\e[0m"
}

# Function to check command success
check_success() {
  if [ $? -ne 0 ]; then
    echo -e "\e[31mError: $1\e[0m"
    exit 1
  fi
}

# Install Tailscale
echo "Installing Tailscale..."
curl -fsSL https://tailscale.com/install.sh | sh
check_success "Tailscale installation failed."
print_success "Tailscale installed successfully."

# Run Determinate Systems Installer (assuming a URL for installation)
echo "Running Determinate Systems Installer..."
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install linux --init none
check_success "Determinate Systems Installer failed."

# Source Nix daemon script
if [ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
  print_success "Nix environment sourced successfully."
else
  echo -e "\e[31mError: Nix daemon script not found.\e[0m"
  exit 1
fi

# Set up Home Manager
echo "Setting up Home Manager..."
nix-shell -p home-manager
check_success "Home Manager setup failed."
print_success "Home Manager setup completed successfully."

# Run first Home Manager generation
echo "Running Home Manager generation..."
home-manager switch --flake github:imcquee/nix-home#universal
check_success "Home Manager generation failed."
print_success "Home Manager generation completed successfully."

echo -e "\e[32mSetup completed successfully.\e[0m"
