{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./bash.nix
    ./espanso.nix
    ./firefox.nix
    ./helix.nix
    ./home.nix
    ./kitty.nix
    ./nixvim.nix
    ./starship.nix
    ./tools.nix
    ./vscode.nix
    ./zsh.nix
  ];
}
