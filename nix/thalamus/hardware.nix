{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  # Configure hardware
  hardware = {
    # Enable firmware regardless of license
    enableAllFirmware = true;

    # Enable updating CPU microcode
    enableRedistributableFirmware = true;
  };
}
