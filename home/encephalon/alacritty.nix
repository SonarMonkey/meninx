{
  config,
  pkgs,
  ...
}: {
  # Configure alacritty
  programs.alacritty = {
    enable = true;

    # Main alacritty configuration
    settings = {
      # Window config
      window = {
        opacity = 0.9;
        blur = true;
        startup_mode = "Windowed";
      };

      # Font config
      font = {
        normal.family = "Cozette";
        normal.style = "Regular";
        bold.style = "Regular";
        italic.style = "Regular";
        bold_italic.style = "Regular";
        size = 8;
        builtin_box_drawing = false;
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
