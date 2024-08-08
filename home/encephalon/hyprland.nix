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

    # Configuration settings
    # TODO configure gestures
    settings = {
      # Variables
      "$mod" = "SUPER";
      "$terminal" = "kitty";
      "$browser" = "firefox";
      "$fileManager" = "nautilus";
      "$webApps" = "re.sonny.Tangram";
      "$code" = "code";
      "$codeAlt" = "zed";
      "$notes" = "heynote";
      "$chat" = "vesktop";
      "$menu" = "tofi-drun";
      "$menuAlt" = "sysmenu";
      "$osdHud" = "syshud";
      "$screenshot" = "grimblast";

      # Startup programs
      exec-once = [
        "wl-paste --watch cliphist store"
        "hyprpaper"
        "hyprnotify"
      ];

      # Keybindings
      bind = [
        # Apps
        "$mod, Enter, exec, $terminal"

        # Controls and menus
        "CTRL, Q, killactive,"
        "$mod, O, exec, $menu"
        "$mod+ALT, O, exec, $menuAlt"
        ", Print, exec, $screenshot"

        # Navigation
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 0"
      ];

      # Mouse bindings
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];

      # Monitor config
      monitor = [
        ",preferred,auto,auto"
      ];

      # Input, mouse, touchpad
      input = {
        kb_layout = "us";
        accel_profile = "flat";
        follow_mouse = 1;

        touchpad = {
          natural_scroll = true;
          clickfinger_behavior = true;
        };
      };

      # Other settings
      misc = {
        disable_hyprland_logo = true;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
      };

      # Cursor config
      cursor = {
        hide_on_key_press = true;
      };
    };
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
