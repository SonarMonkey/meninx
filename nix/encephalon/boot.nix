{
  config,
  pkgs,
  lib,
  ...
}: {
  # Configure generic boot settings
  boot = {
    # Use the latest Linux-zen kernel
    kernelPackages = lib.mkDefault pkgs.linuxPackages_lqx;

    # Enable mutable efivars
    loader.efi.canTouchEfiVariables = true;

    # Use systemd-boot as bootloader
    loader.systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };
  };
}
