{
  config,
  lib,
  pkgs,
  ...
}: {
  # Fish shell theme
  programs.fish.interactiveShellInit = lib.mkForce ''
    fish_config theme choose "Solarized Dark"
  '';

  # Terminal program themes
  programs.helix.settings.theme = lib.mkForce "solarized_dark";
  programs.bat.config.theme = lib.mkForce "Solarized (dark)";
  programs.ghostty.settings.theme = lib.mkForce "Builtin Solarized Dark";
  programs.zellij.settings.theme = lib.mkForce "solarized-dark";
}
