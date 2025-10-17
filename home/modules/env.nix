{ config, ... }:

{
  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];

  home.sessionVariables = {
    BAT_STYLE = "plain";
  };
}
