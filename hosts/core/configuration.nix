{ ... }: {
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
    ../../modules/nginx.nix
    ../../modules/socme.nix
    ../../modules/tailscale.nix
    ../../modules/nvf

    #./headscale.nix

    ./hardware-configuration.nix
  ];

  networking.hostName = "Core-Dev";

  # Don't touch this
  system.stateVersion = "24.05";
}
