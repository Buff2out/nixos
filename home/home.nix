{ config, pkgs, ... }:

{
  imports = [
    ./modules/env.nix
    ./modules/cli-tools.nix
    ./modules/shell.nix
    ./modules/vscode.nix
  ];

  home.file.".inputrc".text = ''
    # Включить режим emacs (по умолчанию)
    set editing-mode emacs
    
    # Alt+Backspace удаляет слово с учётом разделителей
    "\e\x7f": backward-kill-word
    
    # Alt+стрелки для навигации
    "\e
  '';
  
  home.username = "wave";
  home.homeDirectory = "/home/wave";
  home.stateVersion = "25.05";
}
