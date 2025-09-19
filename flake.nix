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
      # pkgs = nixpkgs.legacyPackages.${system}; // Убираем это
      pkgs-stable = nixpkgs-stable.legacyPackages.${system};
    in
    {
      nixosConfigurations.nxos = nixpkgs.lib.nixosSystem {
        inherit system;
        # specialArgs = { inherit pkgs pkgs-stable; }; # Убираем pkgs из specialArgs
        specialArgs = { inherit pkgs-stable; }; # Оставляем только pkgs-stable, если нужно
        modules = [
          ./hosts/nxos/configuration.nix
        ];
      };
    };
}