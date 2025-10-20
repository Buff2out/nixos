{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us,ru";
      options = "grp:alt_shift_toggle";
    };
  };

  # KDE Plasma 6
  services.desktopManager.plasma6.enable = true;
  
  # GNOME
  services.desktopManager.gnome.enable = true;
  
  # ✅ GDM для красивого login screen (вместо SDDM)
  services.displayManager = {
    gdm = {
      enable = true;
      wayland = true;
    };
    # SDDM отключён, используем GDM
    sddm.enable = false;
    
    # Дефолтная сессия GNOME (можешь сменить на plasma если хочешь)
    defaultSession = "gnome";
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  environment.systemPackages = with pkgs; [
    # KDE packages
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
    kdePackages.kamoso
    kdePackages.elisa
    
    # GNOME packages
    gnome-software
    gnome-calculator
    gnome-characters
    gnome-clocks
    gcolor3
    drawing
    gnome-logs
    gnome-text-editor
    gnome-console
    nautilus
    file-roller
    loupe
    snapshot
    gnome-calendar
    gnome-tweaks
    gnome-screenshot  # ✅ для скриншотов
    
    wayland-utils
    wl-clipboard
  ];
  
  # Отключить ненужные GNOME приложения
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-connections
    epiphany
    geary
    totem
    gnome-music
    gnome-maps
    gnome-weather
    cheese
  ];
}
