{
  config,
  pkgs,
  lib,
  ...
}: {
  # Enable font discovery and set defaults
  fonts.fontconfig = {
    # Set defaults
    defaultFonts = {
      serif = ["Cantarell"];
      sansSerif = ["Cantarell"];
      monospace = ["Maple Mono NF"];
      emoji = ["Noto Color Emoji"];
    };
  };

  # GTK settings
  gtk = {
    # Enable configuration
    enable = true;

    # Font settings
    font = {
      package = pkgs.cantarell-fonts;
      name = "Cantarell";
      size = 12;
    };

    # Theme settings
    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3-dark";
    };

    # Icon theme
    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };

    # Cursor theme
    cursorTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };

    # gtk3
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  # Configure QT
  qt = {
    enable = true;
    style.name = "adwaita-dark";
  };

  # Dconf adwaita theme settings
  dconf.settings = with lib.hm.gvariant; {
    # General interface settings
    "org/gnome/desktop/interface" = {
      # Theme
      accent-color = "blue";
      color-scheme = "prefer-dark";
      gtk-theme = "adw-gtk3-dark";
      cursor-theme = "Adwaita";

      # Font
      font-name = "Cantarell 12";
      document-font-name = "Cantarell 12";
      monospace-font-name = "Maple Mono NF 12";
    };

    # Wallpaper and screensaver
    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/amber-l.jxl";
      picture-uri-dark = "file:///run/current-system/sw/share/backgrounds/gnome/amber-d.jxl";
      primary-color = "#ff7800";
      secondary-color = "#000000";
    };

    # Set screensaver and properties
    "org/gnome/desktop/screensaver" = {
      picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/amber-l.jxl";
      primary-color = "#ff7800";
      secondary-color = "#000000";
    };
  };

  # Various application-specific themes
  #programs.helix.settings.theme = "adwaita-dark";
  programs.bat.config.theme = "base16";
  programs.kitty.themeFile = "adwaita_dark";
  programs.vscode.profiles.default.extensions = with pkgs; [vscode-extensions.piousdeer.adwaita-theme];
  programs.vscode.profiles.default.userSettings = {
    # Font settings
    "editor.fontLigatures" = true;
    "editor.fontFamily" = "'Maple Mono NF', 'monospace', monospace";

    # Appearance/UI settings
    "editor.renderLineHighlight" = "none";
    "window.autoDetectColorScheme" = true;
    "window.commandCenter" = true;
    "workbench.tree.indent" = 12;

    # Theme settings
    "workbench.preferredDarkColorTheme" = "Adwaita Dark";
    "workbench.preferredLightColorTheme" = "Adwaita Light";
    "workbench.productIconTheme" = "adwaita";
    "workbench.iconTheme" = null;
  };
}
