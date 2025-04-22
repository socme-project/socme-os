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
    
      # Replace pcap with af-packet for better performance
      af-packet = [{ 
        interface = "ens19";
        cluster-id = 99;
        cluster-type = "cluster_flow";
        defrag = true;
      }];
    
      # Fix the logging configuration structure
      logging = {
        default-log-level = "notice";
        # Correct structure for logging outputs
        console = {
          enabled = true;
        };
        file = {
          enabled = true;
          filename = "/var/log/suricata/suricata.log";
          level = "info";
        };
      };
      
      # Configure outputs correctly
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
            types = [
              { alert = {}; }
              { http = {}; }
              { dns = {}; }
              { tls = {}; }
              { files = {}; }
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
      rule-files = [ "*.rules" ];
    };
  };
     # headtails/tailscale
  services.nginx = {
    enable = true;
    virtualHosts."localhost.local" = {
    };
  };
  
  networking.firewall.allowedTCPPorts = [ 80 443 ];



  # Don't touch this
  system.stateVersion = "24.05";
}
