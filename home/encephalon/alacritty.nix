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
      # Select shell
      shell = "fish";

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

      # Theme settings (gruvbox)
      colors = {
        primary = {
          background = "#282828";
          foreground = "#ebdbb2";
        };
        normal = {
          black = "#282828";
          red = "#cc241d";
          green = "#98971a";
          yellow = "#d79921";
          blue = "#458588";
          magenta = "#b16286";
          cyan = "#689d6a";
          white = "#a89984";
        };
        bright = {
          black = "#928374";
          red = "#fb4934";
          green = "#b8bb26";
          yellow = "#fabd2f";
          blue = "#83a598";
          magenta = "#d3869b";
          cyan = "#8ec07c";
          white = "#ebdbb2";
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
