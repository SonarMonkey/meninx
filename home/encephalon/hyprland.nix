{
  config,
  pkgs,
}: {
  # Install and configure hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
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
}
