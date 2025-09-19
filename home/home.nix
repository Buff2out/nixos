{ config, pkgs, ... }:

let
  commonAliases = {
    hxroot = "sudo hx /etc/nixos/configuration.nix";
    nxr = "sudo nixos-rebuild switch --flake ${config.home.homeDirectory}/nix-config/";
    hxhome = "hx ${config.home.homeDirectory}/nix-config/home/home.nix";
    
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
in
{
  home.username = "wave";
  home.homeDirectory = "/home/wave";
  home.stateVersion = "25.05";
  
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
        ms-vscode.cmake-tools # cmake
        jnoortheen.nix-ide # nix
        esbenp.prettier-vscode # prettier
        davidanson.vscode-markdownlint # .md
        formulahendry.code-runner # code-runner
        llvm-vs-code-extensions.vscode-clangd # clangd
        mhutchie.git-graph # git graph
        # robbowen.synthwave-vscode # synthwave theme
        rust-lang.rust-analyzer # rust analyzer
        vadimcn.vscode-lldb # debugger lldb
        # donjayamanne.gith # git history
        mechatroner.rainbow-csv # support csv
        bradlc.vscode-tailwindcss # css intellisence
      ];
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      eval "$(zoxide init bash)"
    '';
    shellAliases = commonAliases;
  };

  programs.fish = {
    enable = true;
    shellAliases = commonAliases;
    interactiveShellInit = ''
      zoxide init fish | source
    '';
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      directory = {
        truncation_length = 0;
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
      style = "compact";
      inline_height = 20;
      
      enter_accept = true;
      fuzzy = true;
    };
  };
}