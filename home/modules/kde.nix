{ config, pkgs, lib, ... }:

{
  # Настройки KDE Plasma
  home.file.".config/kwinrc".text = lib.generators.toINI {} {
    Compositing = {
      Enabled = true;
      AnimationSpeed = 4;  # 4-5 для плавности как в GNOME
      LatencyPolicy = "Low";
    };
    
    Plugins = {
      blurEnabled = true;
      slideEnabled = true;
      fadeEnabled = true;
      minimizeanimationEnabled = true;
      windowgeometryEnabled = true;
    };
    
    Effect-slide = {
      Duration = 250;
      HorizontalGap = 0;
      VerticalGap = 0;
    };
  };
  
  home.file.".config/kdeglobals".text = lib.generators.toINI {} {
    KDE = {
      SingleClick = false;
    };
  };
}
