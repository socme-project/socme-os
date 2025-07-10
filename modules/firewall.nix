_:
let suricataInterface = "";
in {
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 443 ];
    allowedUDPPortRanges = [ ];

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
