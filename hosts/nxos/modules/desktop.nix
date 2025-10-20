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
  
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
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
    
    # GNOME эквиваленты
    gnome-software          # аналог Discover
    gnome-calculator        # аналог KCalc
    gnome-characters        # аналог KCharSelect
    gnome-clocks            # аналог KClock
    gcolor3                 # аналог KColorChooser
    drawing                 # аналог KolourPaint
    gnome-logs              # аналог KSystemLog
    gnome-text-editor       # аналог Kate
    gnome-console           # аналог Konsole
    nautilus                # аналог Dolphin
    file-roller             # аналог Ark
    loupe                   # аналог Gwenview
    gnome-calendar          # аналог KOrganizer
    gnome-tweaks            # настройки GNOME
    
    wayland-utils
    wl-clipboard
  ];
  
  # Отключить ненужные GNOME приложения
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-connections
    epiphany      # браузер
    geary         # почтовый клиент
    totem         # видеоплеер
    gnome-music
    gnome-maps
    gnome-weather
  ];
}
