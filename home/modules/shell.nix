{ config, pkgs, ... }:

let
  aliases = import ./aliases.nix { inherit config; };
in
{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      eval "$(zoxide init bash)"
      eval "$(starship init bash)"
      export PATH="$HOME/.cargo/bin:$PATH"
    '';
    shellAliases = aliases.commonAliases;
  };

  programs.fish = {
    enable = true;
    shellAliases = aliases.commonAliases;
    interactiveShellInit = ''
      zoxide init fish | source
      starship init fish | source
      atuin init fish | source
      fish_add_path $HOME/.cargo/bin
    '';
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    settings = {
      username = {
        show_always = true;
        style_user = "bold blue";
        format = "[$user]($style)";
      };
      
      hostname = {
        ssh_only = false;
        format = "@[$hostname](bold green) ";
        disabled = false;
      };
      
      directory = {
        truncation_length = 0;
        truncate_to_repo = false;
        style = "bold yellow";
      };
      
      git_branch = {
        symbol = " ";
        style = "bold purple";
      };
      
      git_status = {
        style = "bold red";
      };
      
      package = {
        symbol = "📦 ";
        style = "bold 208";
        display_private = false;
        format = "is [$symbol$version]($style) ";
      };
      
      rust = {
        symbol = "🦀 ";
        style = "bold red";
        format = "via [$symbol$version]($style) ";
      };
      
      python = {
        symbol = "🐍 ";
        style = "bold yellow";
        format = "via [$symbol$version]($style) ";
      };
      
      nodejs = {
        symbol = "⬢ ";
        style = "bold green";
        format = "via [$symbol$version]($style) ";
      };
      
      cmd_duration = {
        min_time = 500;
        format = "took [$duration](bold yellow) ";
        show_milliseconds = false;
      };
      
      line_break = {
        disabled = false;
      };
      
      format = "$username$hostname$directory$git_branch$git_status$package$rust$python$nodejs$cmd_duration$line_break$character";
      
      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
      };
    };
  };

  programs.atuin = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    
    settings = {
      dialect = "us";
      style = "compact";
      inline_height = 20;
      enter_accept = true;
      fuzzy = true;
    };
  };
}
