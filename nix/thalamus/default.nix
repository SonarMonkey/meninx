{
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.disko.nixosModules.disko
    ./base.nix
    ./hardware.nix
    ./disks.nix
    ./secret.nix
    ./server.nix
  ];
}
