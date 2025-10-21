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

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd Hyprland";
        user = "greeter";
      };
    };
  };

  security.pam.services.greetd.enable = true;

  # Synthwave тема для tuigreet
  environment.etc."greetd/tuigreet.toml".text = ''
    [general]
    greeting = "Welcome to NixOS"
    
    [style]
    container_background = "#282a36"
    text_color = "#f8f8f2"
    prompt_color = "#ff79c6"
    time_color = "#bd93f9"
    action_color = "#50fa7b"
    button_background = "#44475a"
    button_foreground = "#f8f8f2"
  '';

  services.blueman.enable = true;

  environment.systemPackages = with pkgs; [
    tuigreet
    blueman
    kdePackages.sddm-kcm     # ← ИСПРАВЛЕНО: добавлен kdePackages
    
    waybar              # панель
    wofi                # лаунчер
    swaylock            # блокировка экрана
    swayidle            # управление простоями

    networkmanagerapplet
    
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
    kdePackages.dolphin

    cliphist

    brightnessctl     # яркость
    pavucontrol       # GUI для управления звуком
    libnotify         # для notify-send
  ];
}
