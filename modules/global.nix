{ inputs, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    inputs.neve.packages.${system}.default
    fd
    bc
    gcc
    git-ignore
    xdg-utils
    wget
    curl
    vim
    git
    ripgrep
    just
    tldr
    tailscale
  ];

  console.keyMap = "fr";
  virtualisation.docker.enable = true;
  networking.networkmanager.enable = true;
}
