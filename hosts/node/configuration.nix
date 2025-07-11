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
    ../../modules/tailscale.nix
    ../../modules/nvf
    ../../modules/wazuh.nix

    ./hardware-configuration.nix
  ];

  networking.hostName = "Node-Dev";

  services.suricata = {
    enable = true;
    settings = {
      vars.address-groups.HOME_NET = "192.168.1.0/24";

      # Use af-packet instead of pcap for better performance
      af-packet = [
        {
          interface = "ens19";
          cluster-id = 99;
          cluster-type = "cluster_flow";
          defrag = true;
        }
      ];

      # Fix the logging configuration structure
      logging = {
        default-log-level = "notice";
        console = {
          enabled = true;
        };
        file = {
          enabled = true;
          filename = "/var/log/suricata/suricata.log";
          level = "info";
        };
      };

      # Configure outputs with absolute paths
      outputs = [
        {
          fast = {
            enabled = true;
            filename = "/var/log/suricata/fast.log";
            append = "yes";
          };
        }
        {
          eve-log = {
            enabled = true;
            filetype = "regular";
            filename = "/var/log/suricata/eve.json";
            community-id = true; # Keep this from the other version
            types = [
              {alert = {tagged-packets = "yes";};} # Combine the alert settings
              {http = {};}
              {dns = {};}
              {tls = {};}
              {files = {};}
            ];
          };
        }
      ];

      # Enable app-layer protocols including modbus
      app-layer.protocols.modbus = {
        enabled = "yes";
        detection-enabled = "yes";
      };

      # Make sure default ruleset is enabled
      default-rule-path = "/var/lib/suricata/rules";
      rule-files = ["*.rules"];
    };
  };

  # headtail/tailscale
  services.nginx = {
    enable = true;
    virtualHosts."localhost.local" = {};
  };

  networking.firewall.allowedTCPPorts = [80 443];

  # Don't touch this
  system.stateVersion = "24.05";
}
