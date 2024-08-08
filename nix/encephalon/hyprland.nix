{
  config,
  pkgs,
}: {
  # Install and ensure system-side for hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Enable idle daemon and screen locker
  programs.hypridle.enable = true;
  programs.hyprlock.enable = true;

  # Allow hyprlock to authenticate
  security.pam.services.hyprlock = {};
}
