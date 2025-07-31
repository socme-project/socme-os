_: let
  suricataInterface = "";
in {
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [];
    allowedUDPPortRanges = [];

    # To enable Suricata, uncomment the following lines and set the interface
    # interfaces."${suricataInterface}" = {
    #   allowedUDPPortRanges = [{
    #     from = 0;
    #     to = 65535;
    #   }];
    #   allowedTCPPortRanges = [{
    #     from = 0;
    #     to = 65535;
    #   }];
    # };
  };
}
