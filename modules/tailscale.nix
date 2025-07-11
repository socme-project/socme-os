_: {
  security.sudo.extraRules = [{
    users = [ "socme" ];
    commands = [
      {
        command = "/etc/profiles/per-user/socme/bin/tailscale";
        options = [ "NOPASSWD" ];
      }
      {
        command = "/run/current-system/sw/bin/tailscale";
        options = [ "NOPASSWD" ];
      }
    ];
  }];
  services.tailscale = {
    enable = true;
    openFirewall = true;
  };

  networking.firewall = {
    trustedInterfaces = [ "tailscale0" ];
    checkReversePath = "loose";
  };
}
