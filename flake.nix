{
  description = "OpenSOC";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    neve.url = "github:redyf/Neve";
    wazuh.url = "github:anotherhadi/wazuh-nix";
  };

  outputs = inputs@{ nixpkgs, ... }: {
    nixosConfigurations = {

      artemis = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          { _module.args = { inherit inputs; }; }
          inputs.wazuh.nixosModules.wazuh
          ./hosts/artemis/configuration.nix
        ];
      };

      zeus = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          { _module.args = { inherit inputs; }; }
          ./hosts/zeus/configuration.nix
        ];
      };

    };
  };
}
