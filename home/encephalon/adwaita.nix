{
  config,
  pkgs,
  lib,
  ...
}: {
  # Adwaita packages
  home.packages = with pkgs; [
    gnome-backgrounds
    adwsteamgtk
    adw-gtk3
  ];

  # Set envvar for theme just in case
  home.sessionVariables.GTK_THEME = "adw-gtk3-dark";

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
      gtk-application-prefer-dark-theme = 1;
    };

    # gtk4
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  # Configure QT
  qt = {
    enable = true;
    style.name = "adwaita-dark";
  };

  # Dconf adwaita theme settings
  dconf.settings = with lib.hm.gvariant; {
    # Set wallpaper and properties
    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/adwaita-l.jxl";
      picture-uri-dark = "file:///run/current-system/sw/share/backgrounds/gnome/adwaita-d.jxl";
      primary-color = "#3071AE";
      secondary-color = "#000000";
    };

    # Set screensaver and properties
    "org/gnome/desktop/screensaver" = {
      picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/adwaita-l.jxl";
      primary-color = "#3071AE";
      secondary-color = "#000000";
    };

    # General interface settings
    "org/gnome/desktop/interface" = {
      # Theme
      color-scheme = "prefer-dark";
      gtk-theme = "adw-gtk3-dark";
      cursor-theme = "Adwaita";

      # Font
      font-antialiasing = "rgba";
      font-hinting = "slight";
      font-name = "Cantarell 12";
      document-font-name = "Cantarell 12";
      monospace-font-name = "Maple Mono NF 12";
    };
  };

  # Various application-specific themes
  programs.helix.settings.theme = "adwaita-dark";
  programs.kitty.themeFile = "adwaita_dark";
  programs.vscode.extensions = with pkgs; [vscode-extensions.piousdeer.adwaita-theme];
  programs.vscode.userSettings = {
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
