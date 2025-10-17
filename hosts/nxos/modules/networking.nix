{ config, pkgs, ... }:

{
  networking.hostName = "nxos";
  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    dnsmasq
    iwd
    nmap
  ];
}
