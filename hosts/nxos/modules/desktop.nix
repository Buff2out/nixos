{ config, pkgs, ... }:

{
  # Hyprland
  programs.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "breeze";
    
    # Настройки темы
    settings = {
      General = {
        Background = "/home/wave/Pictures/wallpapers/retrowave/wp2343900-synthwave-wallpapers.png";
      };
    };
  };

  services.blueman.enable = true;

  environment.systemPackages = with pkgs; [
    blueman
    kdePackages.sddm-kcm     # ← ИСПРАВЛЕНО: добавлен kdePackages
    
    waybar              # панель
    wofi                # лаунчер
    swaylock            # блокировка экрана
    swayidle            # управление простоями
    
    hyprlock
    hyprpaper           # обои
    mako                # уведомления
    grim                # скриншоты
    slurp               # выбор области
    
    kitty               # терминал
    wayland-utils
    wl-clipboard
    hyprsunset

    nautilus

    brightnessctl     # яркость
    pavucontrol       # GUI для управления звуком
    libnotify         # для notify-send
  ];
}
