{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./fish.nix
    ./gaming.nix
    ./hardware.nix
    #./keyboards.nix
    ./locale.nix
    ./nixconf.nix
    ./packages.nix
    ./printing.nix
    ./security.nix
    ./sound.nix
    ./terminal.nix
    ./user.nix
    ./zsh.nix
  ];
}
