{config, ...}: {
  services.openssh = {
    enable = true;
    ports = [22];
    extraConfig = ''
      AllowTcpForwarding yes
      X11Forwarding no
      AllowAgentForwarding no
      AllowStreamLocalForwarding no
      AuthenticationMethods publickey
    '';
    settings = {
      PasswordAuthentication = false;
      AllowUsers = ["socme"]; # or null for all users
      PermitRootLogin = "no";
    };
  };

  networking.firewall.allowedTCPPorts = [22];
}
