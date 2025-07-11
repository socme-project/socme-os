{ pkgs, ... }: {
  programs.zsh.enable = true;
  users = {
    defaultUserShell = pkgs.zsh;
    users.socme = {
      isNormalUser = true;
      home = "/home/socme";
      uid = 1001;
      description = "SOCme account";
      extraGroups = [ "wheel" "networkmanager" "docker" ];
      initialHashedPassword = "$6$I3RukNU8KP0Djt4L$d1lMuR7n.tcDIvUKscNYVrHnGnzpy.t2JZ4kfJYDs0iwVWIlJRd8uVI8eCuRw8HA2pBZJq4.Qylj/0Di3Wge11";

      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMGBTOOWuJQZc9qTNswozTYhje4eYFv2OOmuprZgnSDJ hadi@nixy"
      ];
    };
  };
  nix.settings.allowed-users = [ "socme" ];
}
