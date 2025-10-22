{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    hyprpaper  # основной менеджер обоев
  ];

  # Создай папку для статичных обоев
  system.activationScripts.create_wallpaper_dirs = ''
    mkdir -p /home/wave/Pictures/wallpapers
    chown wave:users /home/wave/Pictures/wallpapers -R
  '';
}
