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
    ./nixvim.nix
    #./starship.nix
    ./terminal.nix
    ./tools.nix
    ./vscode.nix
    ./zsh.nix
  ];
}
