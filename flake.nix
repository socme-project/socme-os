{
  description = "SOCme";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    neve.url = "github:redyf/Neve";
    wazuh.url = "github:anotherhadi/wazuh-nix";
  };

  outputs = inputs@{ nixpkgs, ... }: {
    nixosConfigurations = {

      node = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          { _module.args = { inherit inputs; }; }
          inputs.wazuh.nixosModules.wazuh
          ./hosts/node/configuration.nix
        ];
      };

      core = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          { _module.args = { inherit inputs; }; }
          ./hosts/core/configuration.nix
        ];
      };

    };
  };
}
