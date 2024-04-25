{inputs, ...}: {
  # Import the Disko module and disk configuration
  imports = [
    inputs.disko.nixosModules.disko
    ./disk-configuration.nix
  ];
}
