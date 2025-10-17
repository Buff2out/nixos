{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    mutableExtensionsDir = true;
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
    ];
  };
}
