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
    adwsteamgtk

    # GNOME extensions
    gnomeExtensions.caffeine
    gnomeExtensions.mullvad-indicator
    gnomeExtensions.grand-theft-focus
    gnomeExtensions.app-hider
    gnomeExtensions.alphabetical-app-grid
    gnomeExtensions.thinkpad-battery-threshold
  ];

  # User icon
  home.file.".face".source = ../../assets/face.png;

  # GTK settings
  gtk = {
    enable = true;

    # gtk2 FIXME is this necessary?
    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

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
      "file:///home/sonar/Orgseq"
      "file:///home/sonar/Projects"
    ];
  };

  # Configure QT
  qt = {
    enable = true;
    style.name = "adwaita-dark";
    #platformTheme.name = "adwaita"; FIXME currently broken
  };
}
