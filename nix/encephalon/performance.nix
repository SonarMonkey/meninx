{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  # Performance-related services
  services = {
    # Nice rules for performance
    ananicy = {
      enable = true;
      package = pkgs.ananicy-cpp;
      rulesProvider = pkgs.ananicy-cpp;
    };

    # Filesystem maintenance
    btrfs.autoScrub = {
      enable = true;
      fileSystems = ["/"];
      interval = "monthly";
    };
  };
}
