{
  config,
  pkgs,
  ...
}: {
  # Enable and configure niri
  programs.niri.enable = true;

  # Notification daemon
  services.mako.enable = true;

  # Launcher
  programs.fuzzel.enable = true;

  # Waybar
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    systemd.target = "niri-session.target";
    settings.mainBar.layer = "top";
  };
}
