{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./gaming.nix
    ./hardware.nix
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
