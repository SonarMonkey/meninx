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

    # Catpuccin theme config
    # FIXME disable for GNOME 46
    #./theme.nix
  ];
}
