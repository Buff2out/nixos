{ config, pkgs, lib, ... }:

{
  programs.plasma.enable = true;

  # Полностью перезаписываем конфиги KDE
  programs.plasma.overrideConfig = true;

  # ===== Night Light =====
  programs.plasma.kwin.nightLight = {
    enable         = true;
    mode           = "times";
    temperature.day   = 6500;
    temperature.night = 3300;
    time.evening     = "22:00";
    time.morning     = "10:30";
    transitionTime   = 30;
  };

  # ===== KWin эффекты =====
  programs.plasma.kwin.effects = {
    blur.enable         = true;
    blur.noiseStrength  = 0;
    blur.strength       = 5;
    translucency.enable = true;
    dimInactive.enable  = false;
    wobblyWindows.enable= false;
  };

  # ===== Горячие клавиши =====
  programs.plasma.shortcuts.kwinners = { };

  programs.plasma.shortcuts.kwin = {
    # Переключение окон
    "Walk Through Windows"            = [ "Alt+Tab" "Meta+Tab" ];
    "Walk Through Windows (Reverse)"  = [ "Shift+Alt+Tab" "Meta+Shift+Tab" ];

    # Быстрое тайлинг-расположение
    "Window Quick Tile Left"          = "Meta+Left";
    "Window Quick Tile Right"         = "Meta+Right";
    "Window Quick Tile Top"           = "Meta+Up";
    "Window Quick Tile Bottom"        = "Meta+Down";

    # Макс/мин
    "Window Maximize"                 = [ "Meta+PgUp"      "Meta+Shift+PgUp" ];
    "Window Minimize"                 = [ "Meta+PgDown"    "Meta+Shift+PgDown" ];

    # Полноэкранный режим
    "Window Fullscreen"               = "Meta+F";

    # Переключение Night Night
    "Toggle Night Color"              = "Meta+N";
  };

  # ===== Композитинг =====
  programs.plasma.configFile.kwinrc = {
    Compositing = {
      AnimationSpeed = 4;
      LatencyPolicy  = "Low";
    };
  };

  # ===== Виртуальные рабочие столы =====
  programs.plasma.kwin.virtualDesktops = {
    number = 4;
    rows   = 1;
  };

  # ===== Настройки рабочего пространства =====
  programs.plasma.workspace.clickItemTo = "select";

  # Терминал по умолчанию
  home.sessionVariables.TERMINAL = "wezterm";
}
