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

    # Nice rules for performance
    #ananicy = {
    #  enable = true;
    #  package = pkgs.ananicy-cpp;
    #  rulesProvider = pkgs.ananicy-cpp;
    #};
  };
}
