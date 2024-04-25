{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Get gaming-related packages
  environment.systemPackages = with pkgs; [
    inputs.nix-gaming.packages.x86_64-linux.wine-ge
    inputs.nix-gaming.packages.x86_64-linux.wine-tkg
    wineWowPackages.stagingFull
    lutris
  ];

  # Gaming-specific programs
  programs = {
    # Steam gamescope
    steam.gamescopeSession = {
      enable = true;
      args = [
        "--rt"
        "--steam"
        "--expose-wayland"
        "--framerate-limit 150"
      ];
    };

    # Feral gamemode
    gamemode = {
      # Basic settings
      enable = true;
      enableRenice = true;

      # Advanced configuration
      settings = {
        general = {
          reaper_freq = 5;
          desiredgov = "performance";
          softrealtime = "auto";
          ioprio = 0;
          inhibit_screensaver = 1;
          disable_splitlock = 1;
        };

        # GPU optimizations
        gpu = {
          apply_gpu_optimizations = "accept-responsibility";
          gpu_device = 0;
          nv_powermizer_mode = 1;
          nv_core_clock_mhz_offset = 185;
          nv_mem_clock_mhz_offset = 500;
        };
      };
    };
  };
}
