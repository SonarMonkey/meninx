{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Generic shared configuration
    ../shared

    # Encephalon-specific configuration
    ./adwaita.nix
    ./autostart.nix
    ./dconf.nix
    ./gnome.nix
    ./extensions.nix
    ./niri.nix

    # Disabled modules
    #./theme.nix
  ];
}
