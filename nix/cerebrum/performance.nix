{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  # Enable performance settings for power management
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "performance";
    scsiLinkPolicy = "max_performance";
  };

  # Performance-related services
  services = {
    # Filesystem maintenance
    btrfs.autoScrub = {
      enable = true;
      fileSystems = ["/"];
      interval = "weekly";
    };

    # Nice rules for performance
    ananicy = {
      enable = true;
      package = pkgs.ananicy-cpp;
      rulesProvider = pkgs.ananicy-cpp;
    };
  };
}
