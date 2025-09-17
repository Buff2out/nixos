# this script is binding /etc/nixos/configuration.nix and /etc/nixos/hardware-configuration.nix
# to home read and write permissions, so you can fixind them and after rebuilding

sudo mkdir -p /etc/nixos

sudo cp -rf ~/nix-config/hosts/nxos/configuration.nix /etc/nixos/ 
sudo cp -rf ~/nix-config/hosts/nxos/hardware-configuration.nix /etc/nixos/ 

sudo ln -sf ~/nix-config/hosts/nxos/configuration.nix /etc/nixos/configuration.nix
sudo ln -sf ~/nix-config/hosts/nxos/hardware-configuration.nix /etc/nixos/hardware-configuration.nix

sudo nixos-rebuild switch
home-manager switch --flake ~/nix-config/home
