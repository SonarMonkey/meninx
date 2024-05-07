{
  config,
  pkgs,
  ...
}: {
  # Kitty
  programs.kitty = {
    enable = true;

    # Theme
    theme = "Adwaita dark";

    # Font settings
    font = {
      name = "Maple Mono NF";
      package = pkgs.maple-mono-NF;
      size = 12;
    };

    # General settings
    settings = {
      # Basic configuration
      shell = "zsh";
      kitty_mod = "alt";
      enabled_layouts = "tall";
      disable_ligatures = "cursor";
      mouse_hide_wait = 3;
      copy_on_select = "clipboard";
      strip_trailing_spaces = "smart";
      enable_audio_bell = "no";
      hide_window_decorations = "yes";
      linux_display_server = "wayland";
      startup_session = "~/.config/kitty/layout.conf";

      # Tab bar appearance
      tab_bar_min_tabs = 2;
      tab_bar_edge = "top";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
    };

    # Keybindings
    keybindings = {
      # Windows
      "kitty_mod+h" = "neighboring_window left";
      "kitty_mod+j" = "neighboring_window down";
      "kitty_mod+k" = "neighboring_window up";
      "kitty_mod+l" = "neighboring_window right";
      "kitty_mod+o" = "new_window_with_cwd";

      # Tabs
      "kitty_mod+t" = "new_tab";
      "kitty_mod+shift+l" = "next_tab";
      "kitty_mod+shift+h" = "previous_tab";
      "kitty_mod+1" = "goto_tab 1";
      "kitty_mod+2" = "goto_tab 2";
      "kitty_mod+3" = "goto_tab 3";
      "kitty_mod+4" = "goto_tab 4";
      "kitty_mod+5" = "goto_tab 5";
      "kitty_mod+6" = "goto_tab 6";
      "kitty_mod+7" = "goto_tab 7";
      "kitty_mod+8" = "goto_tab 8";
      "kitty_mod+9" = "goto_tab 9";
    };
  };

  # And the default layout
  home.file.".config/kitty/layout.conf".text = ''
    # Guarantee maximized window
    os_window_state maximized

    # Set layout
    layout tall

    # Create primary "main" window
    launch --type=window --cwd=/home/sonar zsh

    # Create secondary "nix" window
    launch --type=window --cwd=/home/sonar/Nix zsh

    # Create tertiary "btm" window
    launch --type=window --cwd=/home/sonar btm
  '';
}
