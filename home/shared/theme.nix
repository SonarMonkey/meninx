{
  config,
  lib,
  pkgs,
  ...
}: {
  # Fish shell theme
  programs.fish.interactiveShellInit = ''
    fish_config theme choose "Solarized Dark"
  '';

  # Terminal program themes
  programs.helix.settings.theme = "solarized_dark";
  programs.bat.config.theme = "Solarized (dark)";
  programs.ghostty.settings.theme = "Builtin Solarized Dark";
  programs.zellij.settings.theme = "solarized-dark";
}
