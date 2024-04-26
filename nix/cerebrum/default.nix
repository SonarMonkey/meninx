{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Generic shared configuration
    ../shared

    # Cerebrum-specific configuration
    ./amdgpu.nix
    ./boot.nix
    ./gaming.nix
    ./hardware-configuration.nix
    ./home.nix
    ./network.nix
    #./nvidia.nix
    ./packages.nix
    ./performance.nix
    ./kde.nix
  ];
}
