{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Shared configuration
    ./firefox.nix
    ./fish.nix
    ./ghostty.nix
    ./home.nix
    ./kitty.nix
    ./terminal.nix
    ./theme.nix
    ./tools.nix
    ./vscode.nix
    ./zsh.nix

    # Disabled modules
    #./nixvim.nix
    #./helix.nix
  ];
}
