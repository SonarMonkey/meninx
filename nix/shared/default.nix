{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./environment.nix
    ./fhs.nix
    ./gaming.nix
    ./hardware.nix
    ./iphone.nix
    ./locale.nix
    ./network.nix
    ./nixconf.nix
    ./packages.nix
    ./printing.nix
    ./security.nix
    ./sound.nix
    ./terminal.nix
    ./user.nix
    ./virt.nix
  ];
}
