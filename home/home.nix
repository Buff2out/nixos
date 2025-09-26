{ config, pkgs, ... }:

let
  commonAliases = {
    hxroot = "sudo hx /etc/nixos/configuration.nix";
    nxr = "sudo nixos-rebuild switch --flake ${config.home.homeDirectory}/nix-config/";
    hxhome = "hx ${config.home.homeDirectory}/nix-config/home/home.nix";
    
    cd = "z";
    z = "zoxide";
    
    ls = "eza";                    
    ll = "eza -la";                
    lt = "eza --tree";             
    cat = "bat";

    cdev = "bash ${config.home.homeDirectory}/nix-config/scripts/cdev.sh";
    cppdev = "bash ${config.home.homeDirectory}/nix-config/scripts/cppdev.sh";
    rsdev = "bash ${config.home.homeDirectory}/nix-config/scripts/rsdev.sh";
  };
in
{
  nixpkgs.config.allowUnfree = true;
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
    mutableExtensionsDir = true;  # Эта опция должна помочь
    extensions = with pkgs.vscode-extensions; [
      # mkhl.direnv
      ms-vscode.cmake-tools
      jnoortheen.nix-ide
      esbenp.prettier-vscode
      davidanson.vscode-markdownlint
      formulahendry.code-runner
      llvm-vs-code-extensions.vscode-clangd
      mhutchie.git-graph
      rust-lang.rust-analyzer
      vadimcn.vscode-lldb
      mechatroner.rainbow-csv
      bradlc.vscode-tailwindcss
      ziglang.vscode-zig
    ];
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