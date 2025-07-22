{
  config,
  pkgs,
  ...
}: {
  # Full adwaita theme
  specialisation."adwaita".configuration = {
    # Tell 'nh' about specialisation
    xdg.dataFile."home-manager/specialisation".text = "adwaita";

    # Fish shell theme
    programs.fish.interactiveShellInit = ''
      fish_config theme choose "Base16 Default Dark"
    '';

    # Terminal program themes
    programs.helix.settings.theme = "adwaita-dark";
    programs.bat.config.theme = "base16";
    programs.ghostty.settings.theme = "Adwaita Dark";
    programs.zellij.settings.theme = "ansi";
    programs.kitty.themeFile = "adwaita_dark";
  };

  # Solarized terminal applications
  specialisation."solarized".configuration = {
    # Tell 'nh' about specialisation
    xdg.dataFile."home-manager/specialisation".text = "solarized";

    # Fish shell theme
    programs.fish.interactiveShellInit = ''
      fish_config theme choose "Solarized Dark"
    '';

    # Terminal program themes
    programs.helix.settings.theme = "solarized_dark";
    programs.bat.config.theme = "Solarized (dark)";
    programs.ghostty.settings.theme = "Builtin Solarized Dark";
    programs.zellij.settings.theme = "solarized-dark";
  };
}
