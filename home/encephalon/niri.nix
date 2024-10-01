{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Notification daemon
  services.mako.enable = true;

  # Launcher
  programs.fuzzel.enable = true;

  # System bar
  programs.waybar.enable = true;

  # Configure niri
  programs.niri.settings = {
    # Input config
    input = {
      # General input tweaks
      focus-follows-mouse.enable = true;
      warp-mouse-to-focus = true;
      workspace-auto-back-and-forth = true;

      # Keyboard config
      keyboard.xkb = {
        layout = "us";
        options = "ctrl:nocaps";
      };

      # Mouse config
      mouse = {
        accel-profile = "flat";
      };

      # Touchpad config
      touchpad = {
        dwt = true;
        scroll-method = "two-finger";
      };
    };

    # Keybindings (mostly copied from default right now)
    binds = with config.lib.niri.actions; {
      # Show hotkey overlay
      "Mod+Shift+Slash".action.show-hotkey-overlay = [];

      # System audio controls
      "XF86AudioRaiseVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+"];
      "XF86AudioLowerVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-"];
      "XF86AudioMute".action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"];
      "XF86AudioMicMute".action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"];

      # Allow system controls when locked
      "XF86AudioRaiseVolume".allow-when-locked = true;
      "XF86AudioLowerVolume".allow-when-locked = true;
      "XF86AudioMute".allow-when-locked = true;
      "XF86AudioMicMute".allow-when-locked = true;

      # Basic controls
      "Mod+Q".action.close-window = [];
      "Mod+Tab".action.focus-workspace-previous = [];
      "Mod+Comma".action.consume-window-into-column = [];
      "Mod+Period".action.expel-window-from-column = [];
      "Mod+BracketLeft".action.consume-or-expel-window-left = [];
      "Mod+BracketRight".action.consume-or-expel-window-right = [];

      # Session controls
      "Mod+Shift+E".action.quit = [];
      "Mod+Shift+P".action.power-off-monitors = [];

      # Screenshots
      "Print".action.screenshot = [];
      "Ctrl+Print".action.screenshot-screen = [];
      "Alt+Print".action.screenshot-window = [];

      # Window size controls
      "Mod+R".action.switch-preset-column-width = [];
      "Mod+Shift+R".action.switch-preset-window-height = [];
      "Mod+Ctrl+R".action.reset-window-height = [];
      "Mod+F".action.maximize-column = [];
      "Mod+Shift+F".action.fullscreen-window = [];
      "Mod+C".action.center-column = [];

      # Granular window size controls
      "Mod+Minus".action.set-column-width = "-10%";
      "Mod+Equal".action.set-column-width = "+10%";
      "Mod+Shift+Minus".action.set-window-height = "-10%";
      "Mod+Shift+Equal".action.set-window-height = "+10%";

      # Window navigation
      "Mod+Home".action.focus-column-first = [];
      "Mod+End".action.focus-column-last = [];
      "Mod+Left".action.focus-column-left = [];
      "Mod+Down".action.focus-window-down = [];
      "Mod+Up".action.focus-window-up = [];
      "Mod+Right".action.focus-column-right = [];
      "Mod+H".action.focus-column-left = [];
      "Mod+J".action.focus-window-down = [];
      "Mod+K".action.focus-window-up = [];
      "Mod+L".action.focus-column-right = [];

      # Window movement
      "Mod+Ctrl+Home".action.move-column-to-first = [];
      "Mod+Ctrl+End".action.move-column-to-last = [];
      "Mod+Ctrl+Left".action.move-column-left = [];
      "Mod+Ctrl+Down".action.move-window-down = [];
      "Mod+Ctrl+Up".action.move-window-up = [];
      "Mod+Ctrl+Right".action.move-column-right = [];
      "Mod+Ctrl+H".action.move-column-left = [];
      "Mod+Ctrl+J".action.move-window-down = [];
      "Mod+Ctrl+K".action.move-window-up = [];
      "Mod+Ctrl+L".action.move-column-right = [];

      # Monitor navigation
      "Mod+Shift+Left".action.focus-monitor-left = [];
      "Mod+Shift+Down".action.focus-monitor-down = [];
      "Mod+Shift+Up".action.focus-monitor-up = [];
      "Mod+Shift+Right".action.focus-monitor-right = [];
      "Mod+Shift+H".action.focus-monitor-left = [];
      "Mod+Shift+J".action.focus-monitor-down = [];
      "Mod+Shift+K".action.focus-monitor-up = [];
      "Mod+Shift+L".action.focus-monitor-right = [];

      # Monitor window movement
      "Mod+Shift+Ctrl+Left".action.move-column-to-monitor-left = [];
      "Mod+Shift+Ctrl+Down".action.move-column-to-monitor-down = [];
      "Mod+Shift+Ctrl+Up".action.move-column-to-monitor-up = [];
      "Mod+Shift+Ctrl+Right".action.move-column-to-monitor-right = [];
      "Mod+Shift+Ctrl+H".action.move-column-to-monitor-left = [];
      "Mod+Shift+Ctrl+J".action.move-column-to-monitor-down = [];
      "Mod+Shift+Ctrl+K".action.move-column-to-monitor-up = [];
      "Mod+Shift+Ctrl+L".action.move-column-to-monitor-right = [];

      # Workspace navigation
      "Mod+Page_Down".action.focus-workspace-down = [];
      "Mod+Page_Up".action.focus-workspace-up = [];
      "Mod+U".action.focus-workspace-down = [];
      "Mod+I".action.focus-workspace-up = [];

      # Workspace window movement
      "Mod+Ctrl+Page_Down".action.move-column-to-workspace-down = [];
      "Mod+Ctrl+Page_Up".action.move-column-to-workspace-up = [];
      "Mod+Ctrl+U".action.move-column-to-workspace-down = [];
      "Mod+Ctrl+I".action.move-column-to-workspace-up = [];

      # Workspace movement
      "Mod+Shift+Page_Down".action.move-workspace-down = [];
      "Mod+Shift+Page_Up".action.move-workspace-up = [];
      "Mod+Shift+U".action.move-workspace-down = [];
      "Mod+Shift+I".action.move-workspace-up = [];

      # Mouse binds
      "Mod+WheelScrollDown".action.focus-workspace-down = [];
      "Mod+WheelScrollUp".action.focus-workspace-up = [];
      "Mod+Shift+WheelScrollDown".action.focus-column-right = [];
      "Mod+Shift+WheelScrollUp".action.focus-column-left = [];

      # Focus workspaces by index
      "Mod+1".action.focus-workspace = ["1"];
      "Mod+2".action.focus-workspace = ["2"];
      "Mod+3".action.focus-workspace = ["3"];
      "Mod+4".action.focus-workspace = ["4"];
      "Mod+5".action.focus-workspace = ["5"];
      "Mod+6".action.focus-workspace = ["6"];
      "Mod+7".action.focus-workspace = ["7"];
      "Mod+8".action.focus-workspace = ["8"];
      "Mod+9".action.focus-workspace = ["9"];

      # Move columns to workspaces by index
      "Mod+Ctrl+1".action.move-column-to-workspace = ["1"];
      "Mod+Ctrl+2".action.move-column-to-workspace = ["2"];
      "Mod+Ctrl+3".action.move-column-to-workspace = ["3"];
      "Mod+Ctrl+4".action.move-column-to-workspace = ["4"];
      "Mod+Ctrl+5".action.move-column-to-workspace = ["5"];

      "Mod+Ctrl+6".action.move-column-to-workspace = ["6"];
      "Mod+Ctrl+7".action.move-column-to-workspace = ["7"];
      "Mod+Ctrl+8".action.move-column-to-workspace = ["8"];
      "Mod+Ctrl+9".action.move-column-to-workspace = ["9"];

      # Application shortcuts
      "Mod+T".action.spawn = "kitty";
      "Mod+D".action.spawn = "fuzzel";
    };
  };
}
