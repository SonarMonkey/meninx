{
  config,
  pkgs,
  lib,
  ...
}: {
  # Configure generic boot settings
  boot = {
    # Use the latest linux-lqx kernel
    kernelPackages = lib.mkDefault pkgs.linuxPackages_xanmod_latest;

    # Enable mutable efivars
    loader.efi.canTouchEfiVariables = true;

    # Use systemd-boot as bootloader
    loader.systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };
  };
}
