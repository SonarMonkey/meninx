{
  config,
  lib,
  pkgs,
  ...
}: {
  # Enable GDM+GNOME desktop
  services.xserver = {
    # GNOME display manager
    displayManager.gdm = {
      enable = true;
      autoSuspend = false;
    };

    # GNOME desktop environment
    desktopManager.gnome.enable = true;
  };

  # Udev rules for appindicator
  services.udev.packages = [
    pkgs.gnome.gnome-settings-daemon
  ];

  # Configure QT appearance
  qt = {
    enable = true;
    style = "adwaita-dark";
  };
}
