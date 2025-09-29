{ config, lib, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  swapDevices = [
    {
      device = "/swap/swapfile";
      size = 16 * 1024;
    }
  ];

  fileSystems."/".options = [ "compress=zstd" "noatime" ];
  fileSystems."/home" =
  { device = "/dev/disk/by-uuid/662b4ff3-92c7-45fc-ab40-79b140d051b0";
    fsType = "btrfs";
    options = [ "subvol=@home" "rw" "relatime" ];  # Добавьте rw и relatime
  };

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

  imports =
    [
      ./hardware-configuration.nix
    ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nxos";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "ru_RU.UTF-8/UTF-8"
  ];

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  services.xserver.xkb = {
    layout = "us,ru";
    options = "grp:alt_shift_toggle";
  };
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  hardware.graphics = {
    enable = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {

        Experimental = true;
        FastConnectable = true;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    fira-code
  ];

  virtualisation.docker.enable = true;

  services.printing.enable = true;

  users.users.wave = {
    isNormalUser = true;
    home = "/home/wave";
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

  environment.systemPackages = with pkgs; [
    kdePackages.discover
    kdePackages.kcalc
    kdePackages.kcharselect
    kdePackages.kclock
    kdePackages.kcolorchooser
    kdePackages.kolourpaint
    kdePackages.ksystemlog
    kdePackages.sddm-kcm
    kdePackages.kate
    kdePackages.konsole
    kdePackages.dolphin
    kdePackages.ark
    kdePackages.gwenview
    kdePackages.spectacle
    kdePackages.korganizer
    hardinfo2
    wayland-utils
    wl-clipboard

    home-manager

    firefox
    chromium
    librewolf

    mandoc
    vim
    nano
    helix

    vlc
    audacity
    obs-studio

    libreoffice-qt6-fresh

    tor
    unixtools.netstat
    ffmpeg
    atuin
    fzf
    eza
    bat
    procs
    dust
    duf
    starship
    ripgrep
    fd
    p7zip
    mkvtoolnix-cli
    neofetch
    htop
    btop
    git
    wget
    curl
    tree
    zip
    unzip
    zoxide
    qalculate-qt
    jq
    bc
    less
    btrfs-progs

    nushell
    fish

    keepassxc

    telegram-desktop
    qbittorrent

    tor-browser
    rocketchat-desktop

    clang
    clang-tools
    yazi
    # direnv
    nodejs_24
    gnumake
    rustup
    cargo
    rustc
    postgresql
    cmake
    gcc
    gdb
    valgrind
    doxygen
    lcov
    cppcheck
    check
    python3
    python3Packages.pip
    gcovr
    python3Packages.mutagen

    sing-box

    docker
    dnsmasq
    iwd
    nmap

    pipewire
    wireplumber
    vivaldi

    smartmontools
    yt-dlp
    exercism
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  services.openssh.enable = true;
  services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable = true;
    settings = {
      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };



  system.stateVersion = "25.05";

}

