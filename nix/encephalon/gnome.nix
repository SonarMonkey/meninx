{
  config,
  lib,
  pkgs,
  ...
}: {
  # Enable GDM+GNOME desktop
  services = {
    # X11 server
    xserver.enable = true;

    # GNOME display manager
    displayManager.gdm.enable = true;

    # GNOME desktop environment
    desktopManager.gnome.enable = true;
  };

  # Udev rules for appindicator
  services.udev.packages = [
    pkgs.gnome-settings-daemon
  ];
}
