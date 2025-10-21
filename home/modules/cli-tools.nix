{ pkgs, ... }:

{
  home.packages = with pkgs; [
    fd
    ripgrep
    zoxide
    eza
    bat
    procs
    dust
    duf
    helix
    starship
    atuin
    fish
  ];
  
  # WezTerm - современный терминал на Rust
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require 'wezterm'
      local config = wezterm.config_builder()
      
      -- Synthwave цветовая схема
      config.color_scheme = 'Synthwave (base16)'
      
      -- Шрифт с лигатурами
      config.font = wezterm.font('Fira Code', { weight = 'Regular' })
      config.font_size = 11.0
      
      -- Яркие цвета для лучшей видимости
      config.bold_brightens_ansi_colors = true
      
      -- Прозрачность (опционально, можете отключить)
      config.window_background_opacity = 0.95
      
      -- GPU ускорение
      config.front_end = "WebGpu"
      
      -- Табы
      config.enable_tab_bar = true
      config.hide_tab_bar_if_only_one_tab = false
      
      -- Убираем padding если не нравится
      config.window_padding = {
        left = 8,
        right = 8,
        top = 8,
        bottom = 8,
      }
      
      return config
    '';
  };
}
