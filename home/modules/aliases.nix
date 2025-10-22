{ config, ... }:

{
  commonAliases = {
    hxroot = "sudo hx /etc/nixos/configuration.nix";
    nxr = "sudo nixos-rebuild switch --flake ${config.home.homeDirectory}/nix-config/";
    hxhome = "hx ${config.home.homeDirectory}/nix-config/home/home.nix";
    vpn-start = "sing-box run -c ~/nix-server/client-config.json > /dev/null 2>&1 & disown";
    vpn-stop = "pkill -f 'sing-box.*client-config'";
    vpn-status = "pgrep -fa sing-box";
        vpn-restart = "pkill -f 'sing-box.*client-config'; sleep 1; sing-box run -c ~/nix-server/client-config.json > /dev/null 2>&1 & disown";
    
    
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
