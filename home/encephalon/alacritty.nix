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
        decorations = "None";
        startup_mode = "Fullscreen";
      };

      # Font config
      font = {
        normal.family = "Cozette";
        normal.style = "Regular";
        bold.style = "Regular";
        italic.style = "Regular";
        bold_italic.style = "Regular";
        builtin_box_drawing = false;
      };

      # Theme settings (solarized)
      colors = {
        primary = {
          background = "#002b36";
          foreground = "#839496";
        };
        normal = {
          black = "#073642";
          red = "#dc322f";
          green = "#859900";
          yellow = "#b58900";
          blue = "#268bd2";
          magenta = "#d33682";
          cyan = "#2aa198";
          white = "#eee8d5";
        };
        bright = {
          black = "#002b36";
          red = "#cb4b16";
          green = "#586e75";
          yellow = "#657b83";
          blue = "#839496";
          magenta = "#6c71c4";
          cyan = "#93a1a1";
          white = "#fdf6e3";
        };
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
