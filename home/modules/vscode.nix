# home/modules/vscode.nix
{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    mutableExtensionsDir = false;
    
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        bradlc.vscode-tailwindcss
        ms-vscode.cmake-tools
        jnoortheen.nix-ide
        esbenp.prettier-vscode
        davidanson.vscode-markdownlint
        formulahendry.code-runner
        llvm-vs-code-extensions.vscode-clangd
        mhutchie.git-graph
        rust-lang.rust-analyzer
        vadimcn.vscode-lldb
        mechatroner.rainbow-csv
        ziglang.vscode-zig
        tamasfe.even-better-toml
        fill-labs.dependi
        ms-vscode-remote.remote-containers
        ritwickdey.liveserver
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "synthwave-vscode";
          publisher = "RobbOwen";
          version = "0.1.19";
          sha256 = "0lfjgrl7m2aswrj1rj64pgkniq0c9qzghjhsr8pivmsfcq35j39s";
        }
      ];

      keybindings = [
        {
          key = "ctrl+backspace";
          command = "deleteWordPartLeft";
          when = "textInputFocus && !inDebugRepl";
        }
        {
          key = "ctrl+delete";
          command = "deleteWordPartRight";
          when = "textInputFocus && !inDebugRepl";
        }
      ];

      # Новый, правильный способ управления настройками
      userSettings = {
        # Отключаем MCP
        "chat.mcp.access" = "none";
        "chat.agent.enabled" = false;
        "chat.commandCenter.enabled" = false;
        
        # Отключаем Copilot
        "github.copilot.enable" = false;
        "github.copilot.editor.enableAutoCompletions" = false;
        
        # Опционально - другие полезные настройки
        "editor.formatOnSave" = true;
        "editor.defaultFormatter" = "esbenp.prettier-vscode";

        # Автоматически включаем нашу тему
        "workbench.colorTheme" = "SynthWave '84";
      };
    };
  };
}
