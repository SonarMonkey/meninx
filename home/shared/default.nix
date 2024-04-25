{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./bash.nix
    ./emacs.nix
    ./firefox.nix
    ./helix.nix
    ./home.nix
    ./kitty.nix
    ./starship.nix
    ./tools.nix
    ./vscode.nix
    ./zsh.nix
  ];
}
