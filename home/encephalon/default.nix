{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Generic shared configuration
    ../shared

    # Encephalon-specific configuration
    ./autostart.nix
    ./dconf.nix
    ./gnome.nix

    # Hyprland configuration
    #./hyprland.nix

    # Catpuccin theme config
    #./theme.nix

    # Alternative gnome-extensions config
    #./extensions.nix
  ];
}
