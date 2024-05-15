{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./fhs.nix
    ./gaming.nix
    ./hardware.nix
    ./iphone.nix
    ./locale.nix
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
