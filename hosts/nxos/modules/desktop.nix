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
  
  # SDDM для выбора между окружениями
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  environment.systemPackages = with pkgs; [
    # KDE packages (все актуальные для Plasma 6!)
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
    kdePackages.kamoso          # камера (NEW!)
    kdePackages.elisa           # музыкальный плеер (NEW!)
    # kdePackages.merkuro       # современный календарь (опционально)
    
    # GNOME эквиваленты (все современные!)
    gnome-software          # аналог Discover
    gnome-calculator        # аналог KCalc
    gnome-characters        # аналог KCharSelect
    gnome-clocks            # аналог KClock
    gcolor3                 # аналог KColorChooser
    drawing                 # аналог KolourPaint
    gnome-logs              # аналог KSystemLog
    gnome-text-editor       # аналог Kate (заменил gedit в GNOME 42)
    gnome-console           # аналог Konsole (современная замена gnome-terminal)
    nautilus                # аналог Dolphin
    file-roller             # аналог Ark
    loupe                   # аналог Gwenview (заменил eog в GNOME 45)
    snapshot                # камера (заменил cheese в GNOME 44)
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
    cheese        # старая камера (заменена на snapshot)
  ];
}
