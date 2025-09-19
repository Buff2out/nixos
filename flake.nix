{
  description = "NixOS configuration";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    nixpkgs-stable = {
      url = "github:NixOS/nixpkgs/nixos-25.05";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, ... }:
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
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.wave = import ./home/home.nix;
            };
          }
        ];
      };
      
      # Экспортируем home-конфигурацию для standalone использования
      homeConfigurations.wave = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;  # Добавляем pkgs
        modules = [ ./home/home.nix ];
      };
    };
}