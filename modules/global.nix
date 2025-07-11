{
  inputs,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
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
