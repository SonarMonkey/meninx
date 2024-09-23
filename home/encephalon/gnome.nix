{
  config,
  pkgs,
  lib,
  ...
}: {
  # GNOME packages
  home.packages = with pkgs; [
    # GNOME-specific applications
    gnome-boxes
    gnome-tweaks
  ];

  # Enable font discovery
  fonts.fontconfig.enable = true;

  # GTK-related settings
  gtk = {
    enable = true;

    # Nautilus bookmarks
    gtk3.bookmarks = [
      "file:///home/sonar/Nix"
      "file:///home/sonar/Notes"
      "file:///home/sonar/Projects"
      "file:///home/sonar/Documents/Work"
    ];
  };
}
