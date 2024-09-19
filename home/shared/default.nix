{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./firefox.nix
    ./helix.nix
    ./home.nix
    ./kitty.nix
    ./nixvim.nix
    ./terminal.nix
    ./tools.nix
    ./vscode.nix
    ./zsh.nix
  ];
}
