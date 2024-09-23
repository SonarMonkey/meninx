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
    ./theme.nix

    # Disabled modules
    #./adwaita.nix
  ];
}
