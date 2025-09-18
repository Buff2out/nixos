{
  description = "NixOS configuration";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    nixpkgs-stable = {
      url = "github:NixOS/nixpkgs/nixos-25.05";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-stable = nixpkgs-stable.legacyPackages.${system};
    in
    {
      nixosConfigurations.nxos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit pkgs pkgs-stable; };
        modules = [
          ./hosts/nxos/configuration.nix
        ];
      };
    };
}