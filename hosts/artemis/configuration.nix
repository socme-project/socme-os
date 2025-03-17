{ pkgs, inputs, ... }: {
  imports = [
    ../../modules/firewall.nix
    ../../modules/global.nix
    ../../modules/grub.nix
    ../../modules/nix.nix
    ../../modules/shell.nix
    ../../modules/ssh.nix
    ../../modules/timezone.nix
    ../../modules/users.nix
    ../../modules/fail2ban.nix
    ../../modules/nixy.nix

    ./hardware-configuration.nix
  ];

  networking.hostName = "Artemis-Dev";

  programs.wazuh = {
    enable = true;
    username = "admin";
    password = "HMthisismys3cr3tP5ssword34a;";
  };
  programs.suricata = { enable = true; };
  # headtails/tailscale

  # Don't touch this
  system.stateVersion = "24.05";
}
