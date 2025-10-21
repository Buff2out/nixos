{ config, pkgs, lib, ... }:

{
  programs.plasma = {
    enable = true;
    
    # КРИТИЧЕСКИ ВАЖНО: включаем overrideConfig
    # Это удаляет старые конфигурационные файлы и создаёт новые
    # вместо попыток их модифицировать
    overrideConfig = true;
    
    # ===== Night Light =====
    kwin.nightLight = {
      enable = true;
      mode = "times";  # Кастомное время
      temperature = {
        day = 6500;     # Дневная температура по умолчанию
        night = 3300;   # Тёплая ночная температура
      };
      time = {
        evening = "22:00";  # Активация в 22:00
        morning = "10:30";  # Выключение в 10:30
      };
      transitionTime = 30;  # 30 минут плавного перехода
    };
    
    # ===== Горячие клавиши =====
    shortcuts = {
      # Перемещение окон по сторонам экрана
      kwin = {
        "Window Quick Tile Left" = "Meta+Left";
        "Window Quick Tile Right" = "Meta+Right";
        "Window Quick Tile Top" = "Meta+Up";
        "Window Quick Tile Bottom" = "Meta+Down";
        
        # Перемещение в углы (четверти экрана)
        "Window Quick Tile Top Left" = "Meta+Ctrl+Left";
        "Window Quick Tile Top Right" = "Meta+Ctrl+Right";
        "Window Quick Tile Bottom Left" = "Meta+Shift+Left";
        "Window Quick Tile Bottom Right" = "Meta+Shift+Right";
        
        # Максимизация/минимизация
        "Window Maximize" = ["Meta+PgUp" "Meta+Shift+PgUp"];
        "Window Minimize" = ["Meta+PgDown" "Meta+Shift+PgDown"];
        
        # Полноэкранный режим
        "Window Fullscreen" = "Meta+F";
        
        # Переключение Night Color
        "Toggle Night Color" = "Meta+N";
      };
    };
    
    # ===== Эффекты KWin =====
    kwin.effects = {
      # Blur эффект
      blur.enable = true;
      blur.noiseStrength = 0;  # Без шума для чистого blur
      blur.strength = 5;  # Интенсивность размытия (1-15)
      
      # Прозрачность
      translucency.enable = true;
      
      # Другие эффекты
      dimInactive.enable = false;  # Не затемнять неактивные окна
      wobblyWindows.enable = false;  # Отключить эффект "желе"
    };
    
    # ===== Композитинг =====
    configFile = {
      kwinrc = {
        Compositing = {
          AnimationSpeed = 4;  # 4-5 для плавности как в GNOME
          LatencyPolicy = "Low";
        };
      };
    };
    
    # ===== Виртуальные рабочие столы =====
    kwin.virtualDesktops = {
      number = 4;
      rows = 1;
    };
    
    # ===== Рабочее пространство =====
    workspace = {
      clickItemTo = "select";  # Single click = false
    };
  };
  
  # Установка терминала по умолчанию
  home.sessionVariables = {
    TERMINAL = "wezterm";  # или "kitty"
  };
}
