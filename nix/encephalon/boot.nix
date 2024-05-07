{
  config,
  pkgs,
  ...
}: {
  # Configure generic boot settings
  boot = {
    # Use the latest Linux-zen kernel
    kernelPackages = pkgs.linuxPackages_zen;

    # Enable mutable efivars
    loader.efi.canTouchEfiVariables = true;

    # Use systemd-boot as bootloader
    loader.systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };
  };
}
