{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Generic shared configuration
    ../shared

    # Pre-defined hardware configs
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x1-6th-gen
    inputs.nixos-hardware.nixosModules.common-cpu-intel-kaby-lake

    # Encephalon-specific configuration
    ./boot.nix
    ./disko.nix
    ./gaming.nix
    ./gnome.nix
    ./hardware-configuration.nix
    ./home.nix
    ./network.nix
    ./packages.nix
    ./performance.nix
    ./theme.nix
  ];
}
