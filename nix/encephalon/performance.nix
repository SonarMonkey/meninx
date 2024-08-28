{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  # Performance-related services
  services = {
    # Filesystem maintenance
    btrfs.autoScrub = {
      enable = true;
      fileSystems = ["/"];
      interval = "monthly";
    };
  };
}
