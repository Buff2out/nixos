{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # System tools
    hardinfo2
    home-manager
    
    # Browsers
    firefox
    chromium
    librewolf
    vivaldi
    tor-browser
    
    # Editors
    mandoc
    vim
    nano
    helix
    
    # Multimedia
    vlc
    audacity
    obs-studio
    
    # Office
    libreoffice-qt6-fresh
    
    # Network
    tor
    unixtools.netstat
    
    # CLI Tools
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
    smartmontools
    yt-dlp
    
    # Shells
    nushell
    fish
    
    # Security
    keepassxc
    
    # Communication
    telegram-desktop
    qbittorrent
    rocketchat-desktop
    
    # Development
    clang
    clang-tools
    yazi
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
    exercism
    
    # Network tools
    sing-box
  ];

  services.printing.enable = true;
  services.openssh.enable = true;
}
