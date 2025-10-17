{ pkgs, ... }:

{
  home.packages = with pkgs; [
    fd
    ripgrep
    zoxide
    eza
    bat
    procs
    dust
    duf
    helix
    starship
    atuin
    fish
    sing-box
  ];
}
