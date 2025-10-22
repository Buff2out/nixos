{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    mpvpaper
  ];

  # Создай папки для обоев
  system.activationScripts.create_wallpaper_dirs = ''
    mkdir -p /home/wave/Videos/wallpapers/{steam,youtube}
    chown wave:users /home/wave/Videos/wallpapers -R
  '';
}
