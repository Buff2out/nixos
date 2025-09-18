{ config, pkgs, ... }:

{
  home.username = "wave";
  home.homeDirectory = "/home/wave";
  home.stateVersion = "25.05";

  nixpkgs.config.allowUnfree = true;

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

  home.sessionVariables = {
    BAT_STYLE = "plain";
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        llvm-vs-code-extensions.vscode-clangd
        mhutchie.git-graph
        # robbowen.synthwave-vscode
        rust-lang.rust-analyzer
        vadimcn.vscode-lldb
        formulahendry.code-runner
        esbenp.prettier-vscode
        mechatroner.rainbow-csv
      ];
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      eval "$(zoxide init bash)"
    '';
    shellAliases = {
      hxroot = "sudo hx /etc/nixos/configuration.nix";
      nxr = "sudo nixos-rebuild switch";
      hxhome = "hx ${config.home.homeDirectory}/nix-config/home/home.nix";
      nxh = "home-manager switch --flake ${config.home.homeDirectory}/nix-config/home";
      
      find = "fd";
      fd = "fd";
      
      grep = "rg";
      rg = "rg";
      
      cd = "z";
      z = "zoxide";
      
      ls = "eza";                    
      ll = "eza -la";                
      lt = "eza --tree";             
      cat = "bat";                   
    };
  };

  programs.fish = {
    enable = true;
    shellAliases = {
      hxroot = "sudo hx /etc/nixos/configuration.nix";
      nxr = "sudo nixos-rebuild switch";
      hxhome = "hx ${config.home.homeDirectory}/nix-config/home/home.nix";
      nxh = "home-manager switch --flake ${config.home.homeDirectory}/nix-config/home";
      
      find = "fd";
      fd = "fd";
      
      grep = "rg";
      rg = "rg";
      
      cd = "z";
      z = "zoxide";
      
      ls = "eza";                    
      ll = "eza -la";                
      lt = "eza --tree";             
      cat = "bat";                   
    };
    interactiveShellInit = ''
      zoxide init fish | source
    '';
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      directory = {
        truncation_length = 0;  # 0 = показывать полный путь
        truncate_to_repo = false;
        style = "bold yellow";
      };
      
      format = "$all";
      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
      };
    };
  };

  programs.atuin = {
    enable = true;
    enableBashIntegration = true;
    
    settings = {
      dialect = "us";
      style = "compact";  # стиль отображения результатов
      inline_height = 20;  # высота inline окна
      
      # Настройки синхронизации (опционально)
      # sync_address = "https://api.atuin.sh";
      # sync_frequency = "10m";  # частота синхронизации
      
      # Поведение
      enter_accept = true;  # Enter выбирает команду
      fuzzy = true;         # нечеткий поиск
    };
  };
}
