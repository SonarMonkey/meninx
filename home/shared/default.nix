{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Shared configuration
    ./firefox.nix
    ./home.nix
    ./kitty.nix
    ./terminal.nix
    ./tools.nix
    ./vscode.nix
    ./zsh.nix

    # Disabled modules
    #./nixvim.nix
    #./helix.nix
  ];
}
