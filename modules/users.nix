{ pkgs, ... }: {
  programs.zsh.enable = true;
  users = {
    defaultUserShell = pkgs.zsh;
    users.zeus = {
      isNormalUser = true;
      home = "/home/zeus";
      description = "zeus OpenSOC account";
      extraGroups = [ "wheel" "networkmanager" "docker" ];

      # OpenSOC public key
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCTRC6FyGPkN8WlKYT8n5NnCUjWRfJRgOHnDO/7YeLaBDf9Jur6QQpoInKJSkcQ5LClj/+438TJ2qQBV2voXq4nsduD6+qflYAUx1FwL1eWRgpOaicxhQ2fsf2g0pKwDPREjvAymwBSAeyXveGXaiWkVo96DLhb0QzEmUeRY+Jaf0MJZKZIWj9kk2N4vbUrVQyrF05bfTCGjarUDWX0U+OlLjL1XCyQfWNnVuqSQZj2L7oZXpHC7mF+Y9PWLDFJ6U9DiiGYURVmDLYPZ/tbXh2dpcFgPiEW6dOJZLRlQnjFjW3Lf9IG7X96L7SwXvuPWO6CX5vlm+wk1xPZCIKWmgyhR5h543/7No5SnzjqV21723TrLrHDYBs0ZulDTyzJoukcLyiXvuWxjKaPrqx8fBTyI/uGCVmt/fqF2eskegvYjbzU+NW62WikDx2GI8kYDkN7Wwt8MQFlTy4asFSzzNNwKe7vYqqcTOq7inBDpfp+8yES8Va0828hMEbA28Mj8sUga54ZscjStulXnXbSo+GbrC9XprPt5eOQ0yiP3f9fTU2QZGahR/75zFlzUriAquVYUTe7o4KfELwNeAWOnODr1+gm9rDjlMQuTW30X3MvC/8f5efnbAH0k6OzgL1LeqLA/sFjjbOFLW+NlCqW8CV339MaAbhLPJpbklVRBsZKvw== OPENSOC"
      ];
    };
  };
  nix.settings.allowed-users = [ "zeus" ];
}
