{ pkgs, ... }: {
  programs.zsh.enable = true;
  users = {
    defaultUserShell = pkgs.zsh;
    users.core = {
      isNormalUser = true;
      home = "/home/core";
      description = "core SOCme account";
      extraGroups = [ "wheel" "networkmanager" "docker" ];

      # OpenSOC public key
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMGBTOOWuJQZc9qTNswozTYhje4eYFv2OOmuprZgnSDJ hadi@nixy"
      ];
    };
  };
  nix.settings.allowed-users = [ "core" ];
}
