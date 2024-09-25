{
  config,
  pkgs,
  lib,
  ...
}: {
  # Configure alacritty
  programs.alacritty = {
    enable = true;

    # Main alacritty configuration
    settings = {
      # Window config
      window = {
        decorations = "None";
        startup_mode = "Fullscreen";
      };

      # Other misc. settings
      selection.save_to_clipboard = true;
      cursor.style.blinking = "On";
      cursor.vi_mode_style.shape = "Underline";
      cursor.vi_mode_style.blinking = "Off";
      mouse.hide_when_typing = true;
    };
  };
}
