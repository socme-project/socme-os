{...}: {
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

    ./hardware-configuration.nix
  ];

  networking.hostName = "Core-Dev";
  security.acme = {
    acceptTerms = true;
    defaults.email = "socme@socme.com";
  };

  security.acme.certs."socme.wiki" = {
    # This is used to generate SSL certificates
    domain = "socme.wiki";
    extraDomainNames = ["*.socme.wiki"];
    group = "nginx";

    dnsProvider = "cloudflare";
    dnsPropagationCheck = true;
    credentialsFile = "/root/cloudflare.ini"; # A path to your Cloudflare credentials file
  };

  # Don't touch this
  system.stateVersion = "24.05";
}
