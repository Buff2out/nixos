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

  home.packages = with pkgs; [
    rustup
  ];
  
  home.activation = {
    rustupSetup = config.lib.dag.entryAfter ["writeBoundary"] ''
      if command -v rustup &> /dev/null; then
        echo "Setting up Rust toolchain via rustup..."
        ${pkgs.rustup}/bin/rustup default stable
        ${pkgs.rustup}/bin/rustup component add rust-analyzer
        ${pkgs.rustup}/bin/rustup component add clippy
        ${pkgs.rustup}/bin/rustup component add rustfmt
      fi
    '';
  };

  nixpkgs.config.allowUnfree = true;
  
  home.username = "wave";
  home.homeDirectory = "/home/wave";
  home.stateVersion = "25.05";
}
