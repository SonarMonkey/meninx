{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Shared configuration
    ./firefox.nix
    ./helix.nix
    ./home.nix
    ./kitty.nix
    ./terminal.nix
    ./tools.nix
    ./vscode.nix
    ./zsh.nix

    # Disabled modules
    #./nixvim.nix
  ];
}
