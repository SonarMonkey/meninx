{
  config,
  pkgs,
}: {
  # Install and configure hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.variables = ["--all"];
  };

  # Configure hyprlock
  programs.hyprlock = {
    enable = true;
  };

  # Configure hypridle
  services.hypridle = {
    enable = true;
  };

  # Enable hyprpaper
  services.hyprpaper = {
    enable = true;
  };

  # Set pointerCursor to fix themes
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.adwaita-icon-theme;
    name = "Adwaita";
  };
}
