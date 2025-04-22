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

  services.suricata = {
    enable = true;
    settings = {

      vars.address-groups.HOME_NET = "192.168.1.0/24";
      pcap = [{ interface = "ens19"; }];

      outputs = [
        {
          fast = {
            enabled = true;
            filename = "fast.log";
            append = "yes";
          };
        }
        {
          eve-log = {
            enabled = true;
            filetype = "regular";
            filename = "eve.json";
            community-id = true;
            types = [{ alert.tagged-packets = "yes"; }];
          };
        }
      ];
    };
  };

  # headtails/tailscale
  services.nginx = {
    enable = true;
    virtualHosts."localhost.local" = { };
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];

  # Don't touch this
  system.stateVersion = "24.05";
}
