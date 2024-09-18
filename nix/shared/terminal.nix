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

  # Enable starship system-wide
  programs.starship = {
    enable = true;
    presets = [
      "plain-text-symbols"
    ];
  };

  # Ensure completion is available to zsh
  environment.pathsToLink = [
    "/share/bash-completion"
  ];
}
