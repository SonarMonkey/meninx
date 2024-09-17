{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Import nix-index-database
  imports = [inputs.nix-index-database.nixosModules.nix-index];

  # Show password feedback on sudo
  security.sudo.extraConfig = "Defaults pwfeedback";

  # Include .local/bin in path
  environment.localBinInPath = true;

  # Set global environment variables
  environment.variables = {
    NIXOS_OZONE_WL = "1";
  };

  # Permit all shells for user accounts
  environment.shells = with pkgs; [bashInteractive zsh];

  # Set default shell to zsh
  users.defaultUserShell = pkgs.zsh;

  # Enable command-not-found globally (via nix-index)
  programs.nix-index.enable = true;

  # Enable comma wrapped with nix-index-db
  programs.nix-index-database.comma.enable = true;

  # Tune up bash a little
  programs.bash = {
    # Defaults
    completion.enable = true;
    enableLsColors = true;
    vteIntegration = true;

    # Nicer line editor and completion
    blesh.enable = true;
  };

  # Enable and basic options for zsh
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
  };

  # Ensure completion is available to zsh
  environment.pathsToLink = [
    "/share/zsh"
    "/share/bash-completion"
  ];

  # Enable starship system-wide
  programs.starship = {
    enable = true;
    presets = [
      "pure-preset"
    ];
  };
}
