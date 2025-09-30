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
    ./extensions.nix
  ];
}
