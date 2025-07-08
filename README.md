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

1. [Download](https://nixos.org/download/) and [install](https://nixos.wiki/wiki/NixOS_Installation_Guide) NixOS.

2. Install git and vim temporarily to clone the repository and edit files:

```sh
nix-shell -p git vim
```

3. Clone the repository:

```sh
sudo rm -rf /etc/nixos && sudo git clone https://github.com/socme-project/socme-os /etc/nixos
```

4. Update `configuration.nix` with your desired settings.
5. Run the following command to add the hardware configuration for your host:

```sh
sudo bash -c 'nixos-generate-config --show-hardware-config > /etc/nixos/hosts/<node|core>/hardware-configuration.nix'
```

6. Build the system:

```sh
sudo nixos-rebuild switch --flake /etc/nixos#<node|core>
```
