{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./bash.nix
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
