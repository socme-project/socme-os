# SOCME-OS

SOCME-OS is a submodule of SOCME, containing the NixOS configurations for both the Node and Core.

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
