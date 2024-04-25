{
  config,
  pkgs,
  ...
}: {
  # Packages to enable iPhone support
  environment.systemPackages = with pkgs; [
    libimobiledevice
    ifuse
  ];

  # System service to recognize iOS devices
  services.usbmuxd.enable = true;
}
