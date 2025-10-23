self: super: {
  vscode-with-synthwave = super.vscode.overrideAttrs (oldAttrs: {
    postInstall = (oldAttrs.postInstall or "") + ''
      # Инжектим CSS для Neon Dreams в основной workbench CSS
      css_file="$out/lib/vscode/resources/app/out/vs/code/electron-sandbox/workbench/workbench.desktop.main.css"
      
      if [ -f "$css_file" ]; then
        cat >> "$css_file" << 'EOF'

/* SynthWave '84 Neon Dreams - Injected by Nix Overlay */
.mtk5, .mtk6, .mtk7, .mtk8, .mtk9, .mtk10, .mtk11, .mtk12 {
  text-shadow: 0 0 2px #001716, 0 0 3px #03edf975, 0 0 5px #03edf975, 0 0 8px #03edf975;
}

.mtk1 {
  text-shadow: 0 0 2px #000, 0 0 8px #f97e72;
}

.mtk2, .mtk3 {
  text-shadow: 0 0 2px #001716, 0 0 3px #ff006e75, 0 0 5px #ff006e75;
}

.mtk4 {
  text-shadow: 0 0 2px #001716, 0 0 3px #ffbe0b75, 0 0 5px #ffbe0b75;
}

/* Glow effect для целых строк */
.editor-wrapper {
  text-shadow: 0 0 10px #00ff9f50;
}

EOF
      fi
    '';
  });
}
