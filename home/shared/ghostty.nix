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
      font-family = "Maple Mono NF";
      theme = "Adwaita Dark";
      cursor-click-to-move = true;
      mouse-hide-while-typing = true;
      command = "fish -i";
      focus-follows-mouse = true;
      clipboard-read = "allow";
      clipboard-write = "allow";
      clipboard-trim-trailing-spaces = true;
      copy-on-select = "clipboard";
      gtk-titlebar-hide-when-maximized = true;
      gtk-adwaita = true;
    };
  };
}
