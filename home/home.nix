{ config, pkgs, ... }:

{
  imports = [
    ./modules/env.nix
    ./modules/cli-tools.nix
    ./modules/shell.nix
    ./modules/vscode.nix
    ./modules/kde.nix      # Настройки KDE
    ./modules/gnome.nix    # Настройки GNOME
  ];

  nixpkgs.config.allowUnfree = true;
  
  home.username = "wave";
  home.homeDirectory = "/home/wave";
  home.stateVersion = "25.05";
}
