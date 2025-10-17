{ config, ... }:

{
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
}
