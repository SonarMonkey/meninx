{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.hardware.idevice;
in {
  options.hardware.idevice.enable = mkEnableOption "Enable support for iOS devices";
  config = mkIf cfg.enable {
    # Packages to enable iPhone support
    environment.systemPackages = with pkgs; [
      libimobiledevice
      ifuse
    ];

    # System service to recognize iOS devices
    services.usbmuxd.enable = true;
  };
}
