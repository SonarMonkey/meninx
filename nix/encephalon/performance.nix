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

  # Feral gamemode
  programs.gamemode = {
    # Basic settings
    enable = true;

    # May conflict with ananicy
    enableRenice = false;

    # Config
    settings = {
      general = {
        reaper_freq = 5;
        desiredgov = "performance";
        softrealtime = "auto";
        ioprio = 0;
        inhibit_screensaver = 1;
        disable_splitlock = 1;
      };
    };
  };
}
