# SOCME-OS

SOCME-OS is a submodule of SOCME, containing the NixOS configurations for both
Node and Core. 

To deploy the frontend, Core should have an x86-64-v3 architecture.

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

These are configurable modules that can be used across different hosts (fetch,
ssh, etc.)

## Installation

1. [Download](https://nixos.org/download/) and
   [install](https://nixos.wiki/wiki/NixOS_Installation_Guide) NixOS.

### Installation script

2. Just copy this one command:

```sh
bash -i <(curl -fsSL "https://raw.githubusercontent.com/socme-project/socme-os/refs/heads/main/install.sh")
```

### Manual installation

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

If you did not create the user `socme` during installation, go to another tty and log in as `socme` with password `secret`.
