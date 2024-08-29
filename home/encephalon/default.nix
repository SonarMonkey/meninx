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
    ./extensions.nix

    # Disabled modules
    #./hyprland.nix
    #./theme.nix
  ];
}
