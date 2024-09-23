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
    inputs.nixos-hardware.nixosModules.common-gpu-intel-kaby-lake

    # Encephalon-specific configuration
    ./boot.nix
    ./disko.nix
    ./fonts.nix
    ./gnome.nix
    ./hardware-configuration.nix
    ./home.nix
    ./internet.nix
    ./packages.nix
    ./performance.nix
    ./theme.nix

    # Disabled modules
    #./realtime.nix
    #./experiments.nix
  ];
}
