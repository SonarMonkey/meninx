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
    ./experiments.nix
    ./fonts.nix
    ./gaming.nix
    ./gnome.nix
    ./hardware-configuration.nix
    ./home.nix
    ./internet.nix
    ./packages.nix
    ./performance.nix

    # Disabled modules
    #./realtime.nix
    #./theme.nix
    #./tailscale.nix
  ];
}
