{
  config,
  pkgs,
  ...
}: {
  # Related packages and utilities
  home.packages = with pkgs; [
    grimblast
    hyprnotify
    syshud
    sysmenu
    tofi
    cliphist
  ];

  # Install and configure hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.variables = ["--all"];
  };

  # Configure hyprlock
  programs.hyprlock = {
    enable = true;

    # Configuration settings
    settings = {
      # General config
      general = {
        grace = 300;
        hide_cursor = true;
      };

      # Wallpaper settings
      background = [
        {
          path = "screenshot";
          blur_passes = 3;
          blur_size = 8;
        }
      ];

      # Input field settings
      input-field = [
        {
          size = "200, 50";
          position = "0, -80";
          monitor = "";
          dots_center = true;
          fade_on_empty = false;
          font_color = "rgb(202, 211, 245)";
          inner_color = "rgb(91, 96, 120)";
          outer_color = "rgb(24, 25, 38)";
          outline_thickness = 5;
          placeholder_text = "Password...";
          shadow_passes = 2;
        }
      ];
    };
  };

  # Configure hypridle
  services.hypridle = {
    enable = true;

    # Configuration settings
    settings = {
      # General config
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      # Listeners for idle timeouts
      # TODO add screen/kbd dimmer
      listener = [
        # Lock screen after 10mins
        {
          timeout = 600;
          on-timeout = "hyprlock";
        }

        # Turn off display after 15mins
        {
          timeout = 900;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };

  # Enable hyprpaper
  services.hyprpaper = {
    enable = true;

    # Configure wallpaper
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;
      preload = ["~/Pictures/Wallpapers/wallpaper1.png"];
      wallpaper = [",~/Pictures/Wallpapers/wallpaper1.png"];
    };
  };

  # Set pointerCursor to fix themes
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.adwaita-icon-theme;
    name = "Adwaita";
  };
}
