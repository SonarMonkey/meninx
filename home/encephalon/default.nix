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
    ./alacritty.nix
    ./dconf.nix
    ./gnome.nix
    ./extensions.nix

    # Disabled modules
    #./theme.nix
  ];
}
