# home/modules/vscode.nix
{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    mutableExtensionsDir = false;
    
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        ms-vscode.makefile-tools
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
          version = "0.1.20";
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

      userSettings = {
        "chat.mcp.access" = "none";
        "chat.agent.enabled" = false;
        "chat.commandCenter.enabled" = false;
        "github.copilot.enable" = false;
        "github.copilot.editor.enableAutoCompletions" = false;
        
        "editor.formatOnSave" = true;
        "editor.defaultFormatter" = "esbenp.prettier-vscode";

        "workbench.colorTheme" = "SynthWave '84";

        "files.autoSave" = "afterDelay";
        "files.autoSaveDelay" = 1000;  # 1000ms = 1 секунда
        
        "git.confirmSync" = false;              # Не спрашивать при sync
        "git.confirmPush" = false;              # Не спрашивать при push
        "git.confirmEmptyCommits" = false;      # Не спрашивать про пустые коммиты
        "git.enableSmartCommit" = true;         # Автоматически stage при коммите
        "git.postCommitCommand" = "none";       # Не запускать команды после коммита
        
        "git.showPushSuccessNotification" = true;  # Показать уведомление об успешном push (опционально)
      };
    };
  };
}
