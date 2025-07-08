#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status.
set -euo pipefail

read -rp "Machine type (node|core) ? " type
if [[ "$type" != "node" && "$type" != "core" ]]; then
  echo "Error: Invalid machine type. Please enter 'node' or 'core'." >&2
  exit 1
fi

# Confirm destructive action
read -rp "This script will remove /etc/nixos. Are you sure? (y/N) " confirm_rm
if [[ ! "$confirm_rm" =~ ^[Yy]$ ]]; then
  echo "Operation cancelled."
  exit 0
fi

echo "Removing existing /etc/nixos..."
sudo rm -rf /etc/nixos || {
  echo "Error: Failed to remove /etc/nixos." >&2
  exit 1
}

echo "Cloning NixOS configuration repository..."
# Using nix-shell to ensure git is available.
sudo nix-shell -p git --run "git clone https://github.com/socme-project/socme-os /etc/nixos" || {
  echo "Error: Failed to clone repository to /etc/nixos." >&2
  exit 1
}

echo "Generating hardware configuration..."
# Use sudo with tee to handle redirection as root
sudo nixos-generate-config --show-hardware-config | sudo tee "/etc/nixos/hosts/${type}/hardware-configuration.nix" >/dev/null || {
  echo "Error: Failed to generate hardware configuration." >&2
  exit 1
}

echo "Rebuilding NixOS system..."
sudo nixos-rebuild switch --flake "/etc/nixos#$type" || {
  echo "Error: Failed to rebuild NixOS system." >&2
  exit 1
}

echo "NixOS setup complete for type: $type."
