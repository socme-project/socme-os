{
  description = "SOCme";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    socme.url = "github:socme-project/socme";
    nvf = {
      url = "github:notashelf/nvf";
    };
  };

  outputs = inputs @ {nixpkgs, ...}: {
    nixosConfigurations = {
      node = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          {_module.args = {inherit inputs;};}
          inputs.nvf.nixosModules.default
          ./hosts/node/configuration.nix
        ];
      };

      core = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          {_module.args = {inherit inputs;};}
          inputs.nvf.nixosModules.default
          inputs.socme.nixosModules.socme-backend
          ./hosts/core/configuration.nix
        ];
      };
    };
  };
}
