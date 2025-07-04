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
    adw-gtk3
    adwsteamgtk
  ];

  # Enable font discovery
  fonts.fontconfig.enable = true;
}
