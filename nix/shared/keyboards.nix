{
  config,
  pkgs,
  ...
}: {
  # Hardware-related system packages
  environment.systemPackages = with pkgs; [
    via
    vial
    qmk
    qmk_hid
    zmkBATx
    ungoogled-chromium
  ];

  # Udev rules for via and qmk
  services.udev.packages = with pkgs; [
    via
    qmk-udev-rules
  ];

  # Non-root access to QMK boards
  hardware.keyboard.qmk.enable = true;
}
