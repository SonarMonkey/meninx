{
  config,
  pkgs,
  ...
}: {
  # Configure QT
  qt = {
    enable = true;
    style = {
      name = "breeze";
      package = pkgs.kdePackages.breeze;
    };
  };

  # Configure GTK
  gtk = {
    enable = true;

    # Theme
    theme = {
      name = "Breeze-Dark";
      package = pkgs.kdePackages.breeze-gtk;
    };

    # Icons
    iconTheme = {
      name = "Breeze-Dark";
      package = pkgs.kdePackages.breeze-icons;
    };

    # Font
    font = {
      name = "Noto Sans";
      size = 10;
      package = pkgs.noto-fonts;
    };

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
  };

  # Enable KDE Connect
  services.kdeconnect = {
    enable = true;
    indicator = true;
    package = pkgs.kdePackages.kdeconnect-kde;
  };
}
