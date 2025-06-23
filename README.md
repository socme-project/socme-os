# SOCME-OS

SOCME-OS is a submodule of SOCME, containing the NixOS configurations for both the Artemis and Zeus.

## Architecture

### 💻 /hosts

The directory contains host-specific configurations. Each host includes:

- `configuration.nix` for system-wide settings
- `hardware-configuration.nix` for hardware-specific settings

### 📦 /modules

These are configurable modules that can be used across different hosts (fetch, ssh, etc.)
