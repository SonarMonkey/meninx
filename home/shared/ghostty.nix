{
  config,
  pkgs,
  ...
}: {
  # Ghostty
  programs.ghostty = {
    enable = true;
    installBatSyntax = true;
    installVimSyntax = true;

    # General settings
    settings = {
      # Appearance
      font-family = "Maple Mono NF";
      theme = "Adwaita Dark";
      gtk-titlebar-hide-when-maximized = true;
      gtk-adwaita = true;

      # Startup
      command = "fish -i";
      maximize = true;

      # Mouse settings
      cursor-click-to-move = true;
      mouse-hide-while-typing = true;
      focus-follows-mouse = true;

      # Clipboard usage
      clipboard-read = "allow";
      clipboard-write = "allow";
      clipboard-trim-trailing-spaces = true;
      copy-on-select = "clipboard";
    };
  };

  # Zellij layout until https://github.com/ghostty-org/ghostty/discussions/2480
  programs.zellij = {
    enable = true;

    # Only enable fish integration
    enableBashIntegration = false;
    enableZshIntegration = false;
    enableFishIntegration = true;

    # Resume and exit automatically
    attachExistingSession = true;
    exitShellOnExit = true;

    # General settings
    settings = {
      default_shell = "fish";
      copy_command = "wl-copy";
    };
  };
}
