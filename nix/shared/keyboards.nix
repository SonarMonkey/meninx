{
  config,
  pkgs,
  ...
}: {
  # Hardware-related system packages
  environment.systemPackages = with pkgs; [
    via
    qmk
  ];

  # Udev rules for via and qmk
  services.udev.packages = with pkgs; [
    via
    qmk-udev-rules
  ];

  # Non-root access to QMK boards
  hardware.keyboard.qmk.enable = true;
}
