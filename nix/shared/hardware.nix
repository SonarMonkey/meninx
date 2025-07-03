{
  config,
  pkgs,
  ...
}: {
  # Hardware-related system packages
  environment.systemPackages = with pkgs; [
    piper
    via
    libimobiledevice
  ];

  # Enable virtualisation
  virtualisation.libvirtd.enable = true;

  # Hardware related services
  services = {
    # Firmware updater
    fwupd.enable = true;

    # Configuration daemon for mice
    ratbagd.enable = true;

    #GVFS for auto-mounting and stuff
    gvfs.enable = true;

    # System service to recognize iOS devices
    usbmuxd = {
      enable = true;
      package = pkgs.usbmuxd2;
    };

    # Udev rules
    udev.packages = [
      pkgs.via
    ];
  };

  # Other hardware configs
  hardware = {
    # Enable firmware regardless of license
    enableAllFirmware = true;

    # Enable updating CPU microcode
    enableRedistributableFirmware = true;

    # Non-root access to QMK boards
    keyboard.qmk.enable = true;

    # OpenTabletDriver daemon, GUI, & udev rules
    opentabletdriver = {
      enable = true;
      daemon.enable = true;
    };
  };
}
