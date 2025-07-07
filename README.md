# SOCME-OS

SOCME-OS is a submodule of SOCME, containing the NixOS configurations for both Node and Core.

## Table of Contents

- [Table of Contents](#table-of-contents)
- [Architecture](#architecture)
  - [💻 /hosts](#-hosts)
  - [📦 /modules](#-modules)

## Architecture

### 💻 /hosts

The directory contains host-specific configurations. Each host includes:

- `configuration.nix` for system-wide settings
- `hardware-configuration.nix` for hardware-specific settings

### 📦 /modules

These are configurable modules that can be used across different hosts (fetch, ssh, etc.)

## Installation

1. Clone the repository:
`git clone https://github.com/socme-project/socme-os`
2. Update `variables.nix` with your device settings.
3. Copy your `/etc/hardware-configuration.nix` to `hosts/<hostname>/hardware-configuration.nix`.
4. Build the system:
`sudo nixos-rebuild switch --flake /etc/nixos#yourhostname`
5. Reboot your system.
