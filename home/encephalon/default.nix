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
    ./alacritty.nix
    ./dconf.nix
    ./gnome.nix
    ./extensions.nix

    # Disabled modules
    #./theme.nix
  ];
}
