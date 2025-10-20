{ config, pkgs, lib, ... }:

{
  # Настройки GNOME через dconf
  dconf.settings = {
    # Смена раскладки на Alt+Shift
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
    
    # ✅ Скриншоты через Spectacle (KDE tool работает в GNOME!)
    "org/gnome/settings-daemon/plugins/media-keys" = {
      # Отключить встроенные GNOME скриншоты
      screenshot = [];
      area-screenshot = [];
      window-screenshot = [];
      screencast = [];
      
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
      ];
    };
    
    # Ctrl+Alt+T для терминала
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Open Terminal";
      command = "${pkgs.gnome-console}/bin/kgx";
      binding = "<Control><Alt>t";
    };
    
    # ✅ PrtScr = сохранить в файл (полный экран)
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      name = "Screenshot with Flameshot";
      command = "${pkgs.flameshot}/bin/flameshot gui";
      binding = "<Shift>Print";
    };

    # Shift+PrtScr = сохранить полный экран
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      name = "Screenshot Full Screen";
      command = "${pkgs.flameshot}/bin/flameshot full -p ~/Pictures/Screenshots/";
      binding = "Print";
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
      Name=Console
      Exec=${pkgs.gnome-console}/bin/kgx
      Icon=org.gnome.Console
      Terminal=false
      Categories=System;TerminalEmulator;
      X-GNOME-Autostart-enabled=true
    '';
  };
}
