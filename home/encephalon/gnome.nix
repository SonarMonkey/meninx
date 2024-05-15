{
  config,
  pkgs,
  lib,
  ...
}: {
  # GNOME packages
  home.packages = with pkgs; [
    # GNOME-specific applications
    gnome.gnome-boxes
    gnome.gnome-tweaks
    gnome.gnome-backgrounds
    adwsteamgtk

    # GNOME extensions
    gnomeExtensions.alphabetical-app-grid
    gnomeExtensions.app-hider
    gnomeExtensions.caffeine
    gnomeExtensions.grand-theft-focus
    gnomeExtensions.happy-appy-hotkey
    gnomeExtensions.thinkpad-battery-threshold
  ];

  # Set envvar for theme just in case
  home.sessionVariables.GTK_THEME = "adw-gtk3-dark";

  # Enable font discovery and set defaults
  fonts.fontconfig = {
    enable = true;

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
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };

    # Cursor theme
    cursorTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };

    # gtk3
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    # gtk4
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    # Nautilus bookmarks
    gtk3.bookmarks = [
      "file:///home/sonar/Nix"
      "file:///home/sonar/Notes"
      "file:///home/sonar/Projects"
      "file:///home/sonar/Documents/Work"
    ];
  };

  # Configure QT
  qt = {
    enable = true;
    style.name = "adwaita-dark";
  };
}
