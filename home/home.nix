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

  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];
  
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
      bradlc.vscode-tailwindcss         #
      ms-vscode.cmake-tools             # cmake-tools
      jnoortheen.nix-ide                # nix-ide
      esbenp.prettier-vscode            # prettier
      davidanson.vscode-markdownlint    # markdown
      formulahendry.code-runner         #
      llvm-vs-code-extensions.vscode-clangd
      mhutchie.git-graph
      rust-lang.rust-analyzer
      vadimcn.vscode-lldb
      mechatroner.rainbow-csv
      ziglang.vscode-zig
      tamasfe.even-better-toml
      fill-labs.dependi
    ];
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      eval "$(zoxide init bash)"
      export PATH="$HOME/.cargo/bin:$PATH"
    '';
    shellAliases = commonAliases;
  };

  programs.fish = {
    enable = true;
    shellAliases = commonAliases;
    interactiveShellInit = ''
      zoxide init fish | source
      fish_add_path $HOME/.cargo/bin
      
      # Starship для fish
      starship init fish | source
      
      # Atuin для fish (если хочешь)
      atuin init fish | source
    '';
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;  # добавь для fish
    settings = {
      # Показывай username и hostname
      username = {
        show_always = true;
        style_user = "bold blue";
        format = "[$user]($style)";
      };
      
      hostname = {
        ssh_only = false;  # показывать всегда, не только по SSH
        format = "@[$hostname](bold green) ";
        disabled = false;
      };
      
      directory = {
        truncation_length = 0;
        truncate_to_repo = false;
        style = "bold yellow";
      };
      
      # Формат: wave@nxos ~/path ❯
      format = "$username$hostname$directory$git_branch$git_status$character";
      
      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
      };
      
      git_branch = {
        symbol = " ";
        style = "bold purple";
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