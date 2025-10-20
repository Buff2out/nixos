{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/desktop.nix
    ./modules/nvidia.nix
    ./modules/audio.nix
    ./modules/bluetooth.nix
    ./modules/virtualisation.nix
    ./modules/fonts.nix
    ./modules/gaming.nix
    ./modules/networking.nix
    ./modules/locale.nix
    ./modules/battery.nix
    ./modules/packages.nix
  ];

  nixpkgs.config.allowUnfree = true;

  # Swap
  swapDevices = [
    {
      device = "/swap/swapfile";
      size = 16 * 1024;
    }
  ];

  systemd.services."create-swapfile" = {
    description = "Create Btrfs swapfile";
    wantedBy = [ "multi-user.target" ];
    after = [ "local-fs.target" ];
    requires = [ "local-fs.target" ];
    unitConfig = {
      ConditionPathExists = "!/swap/swapfile";
    };
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      mkdir -p /swap
      ${pkgs.btrfs-progs}/bin/btrfs filesystem mkswapfile --size 32g /swap/swapfile
      chmod 0600 /swap/swapfile
    '';
  };

  # Filesystems
  fileSystems."/".options = [ "compress=zstd" "noatime" ];
  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/662b4ff3-92c7-45fc-ab40-79b140d051b0";
    fsType = "btrfs";
    options = [ "subvol=@home" "rw" "relatime" ];
  };

  # Boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # User
  users.users.wave = {
    isNormalUser = true;
    home = "/home/wave";
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
      "podman"
      "libvirtd"
      "audio"
      "video"
    ];
  };

  programs.fish.enable = true;

  system.stateVersion = "25.05";
}
