{
  config,
  pkgs,
  ...
}: {
  # Gaming-specific programs
  programs = {
    # Feral gamemode
    gamemode = {
      # Basic settings
      enable = true;
      enableRenice = true;
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
  };
}
