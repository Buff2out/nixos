{ config, pkgs, lib, ... }:

{
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
    
    # ✅ ПРОСТО МЕНЯЕМ МЕСТАМИ шорткаты GNOME Shell Screenshot UI!
    "org/gnome/shell/keybindings" = {
      # По умолчанию: Print = интерактивный UI
      # Меняем на: Shift+Print = интерактивный UI (область)
      show-screenshot-ui = ["<Shift>Print"];
      
      # Отключаем старые deprecated шорткаты
      screenshot = [];
      screenshot-window = [];
      show-screen-recording-ui = ["<Control><Shift><Alt>r"];  # Оставляем запись экрана
    };
    
    # ✅ Print = сохранить весь экран сразу (не через UI, а напрямую)
    "org/gnome/settings-daemon/plugins/media-keys" = {
      # Отключаем все старые
      screenshot = [];
      area-screenshot = [];
      window-screenshot = [];
      
      # Добавляем свой для Print
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };
    
    # ✅ Print = полный экран -> автосохранение в ~/Pictures/Screenshots
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Full Screen Screenshot";
      # Используем встроенный gnome-screenshot -f для полного экрана
      command = "sh -c 'mkdir -p ~/Pictures/Screenshots && gnome-screenshot -f ~/Pictures/Screenshots/screenshot-$(date +%Y%m%d-%H%M%S).png'";
      binding = "Print";
    };
  };
  
  # Автозагрузка приложений
  home.file = {
    ".config/autostart/firefox.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=Firefox
      Exec=firefox
      Icon=firefox
      Terminal=false
      Categories=Network;WebBrowser;
      X-GNOME-Autostart-enabled=true
    '';
    
    ".config/autostart/rocketchat.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=Rocket.Chat
      Exec=rocketchat-desktop
      Icon=rocketchat-desktop
      Terminal=false
      Categories=Network;InstantMessaging;
      X-GNOME-Autostart-enabled=true
    '';
    
    ".config/autostart/gnome-console.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=Console
      Exec=kgx
      Icon=org.gnome.Console
      Terminal=false
      Categories=System;TerminalEmulator;
      X-GNOME-Autostart-enabled=true
    '';
  };
}
