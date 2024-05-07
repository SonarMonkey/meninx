{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Generic shared configuration
    ../shared

    # Encephalon-specific configuration
    ./dconf.nix
    ./gnome.nix

    # FIXME disable temporarily
    #./autostart.nix

    # Catpuccin theme config
    # FIXME disable for GNOME 46
    #./theme.nix
  ];
}
