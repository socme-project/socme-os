# SOCME-OS

SOCME-OS est un sous-module de SOCME, contenant les configurations NixOS pour
Node et Core.

Pour déployer le frontend, Core doit avoir une architecture x86-64-v3.

## Table des matières

- [Table des matières](#table-des-matières)
- [Architecture](#architecture)
  - [💻 /hosts](#-hosts)
  - [📦 /modules](#-modules)

## Architecture

### 💻 /hosts

Le répertoire contient les configurations spécifiques aux hôtes. Chaque hôte
inclut un `configuration.nix` pour les paramètres.

### 📦 /modules

Ce sont des modules configurables qui peuvent être utilisés sur différents hôtes
(fetch, ssh, etc.)

## Installation

1. [Téléchargez](https://nixos.org/download/) et
   [installez](https://nixos.wiki/wiki/NixOS_Installation_Guide) NixOS.

### Script d'installation

2. Copiez simplement cette commande :

```sh
bash -i <(curl -fsSL "https://raw.githubusercontent.com/socme-project/socme-os/refs/heads/main/install.sh")
```

### Installation manuelle

2. Installez git et vim temporairement pour cloner le dépôt et éditer les fichiers :

```sh
nix-shell -p git vim
```

3. Clonez le dépôt :

```sh
sudo rm -rf /etc/nixos && sudo git clone https://github.com/socme-project/socme-os /etc/nixos
```

4. Mettez à jour `configuration.nix` avec vos paramètres souhaités.
5. Exécutez la commande suivante pour ajouter la configuration matérielle de votre hôte :

```sh
sudo bash -c 'nixos-generate-config --show-hardware-config > /etc/nixos/hosts/<node|core>/hardware-configuration.nix'
```

6. Construisez le système :

```sh
sudo nixos-rebuild switch --flake /etc/nixos#<node|core>
```

Si vous n'avez pas créé l'utilisateur `socme` lors de l'installation, allez dans
une autre tty et connectez-vous en tant que `socme` avec le mot de passe `secret`.
