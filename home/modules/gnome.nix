{ config, pkgs, lib, ... }:

{
  # Настройки GNOME через dconf
  dconf.settings = {
    # Смена раскадки на Alt+Shift
    "org/gnome/desktop/wm/keybindings" = {
      switch-input-source = ["<Shift>Alt_L"];
      switch-input-source-backward = ["<Alt>Shift_L"];
    };
    
    # Скорость повтора клавиш
    "org/gnome/desktop/peripherals/keyboard" = {
      delay = lib.hm.gvariant.mkUint32 250;
      repeat-interval = lib.hm.gvariant.mkUint32 15;
      repeat = true;
    };
    
    # Ctrl+Alt+T для терминала
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };
    
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Open Terminal";
      command = "gnome-console";  # ✅ современный терминал
      binding = "<Control><Alt>t";
    };
  };
  
  # Автозагрузка приложений
  home.file = {
    ".config/autostart/firefox.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=Firefox
      Exec=${pkgs.firefox}/bin/firefox
      Icon=firefox
      Terminal=false
      Categories=Network;WebBrowser;
      X-GNOME-Autostart-enabled=true
    '';
    
    ".config/autostart/rocketchat.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=Rocket.Chat
      Exec=${pkgs.rocketchat-desktop}/bin/rocketchat-desktop
      Icon=rocketchat-desktop
      Terminal=false
      Categories=Network;InstantMessaging;
      X-GNOME-Autostart-enabled=true
    '';
    
    ".config/autostart/gnome-console.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=Terminal
      Exec=${pkgs.gnome-console}/bin/gnome-console
      Icon=utilities-terminal
      Terminal=false
      Categories=System;TerminalEmulator;
      X-GNOME-Autostart-enabled=true
    '';
  };
}
