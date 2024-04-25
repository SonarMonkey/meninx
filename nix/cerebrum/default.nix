{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Generic shared configuration
    ../shared

    # TODO pre-defined hardware configs?

    # Cerebrum-specific configuration
    ./boot.nix
    ./gaming.nix
    ./hardware-configuration.nix
    ./home.nix
    ./network.nix
    ./nvidia.nix
    ./packages.nix
    ./performance.nix
    ./kde.nix
  ];
}
