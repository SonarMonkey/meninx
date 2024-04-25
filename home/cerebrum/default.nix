{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Generic shared configuration
    ../shared

    # Cerebrum-specific configuration
    ./kde.nix
  ];
}
