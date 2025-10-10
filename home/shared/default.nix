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
    ./terminal.nix
    ./tools.nix
    ./vscode.nix
    ./zen.nix

    # Disabled modules
    #./nixvim.nix
    #./kitty.nix
    #./theme.nix
    #./helix.nix
    #./zsh.nix
  ];
}
