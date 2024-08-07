{
  config,
  pkgs,
  ...
}: {
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

  # Enable command-not-found globally
  programs.command-not-found.enable = true;

  # Tune up bash a little
  programs.bash = {
    # Defaults
    completion.enable = true;
    enableLsColors = true;

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
  environment.pathsToLink = ["/share/zsh"];

  # Enable starship system-wide
  programs.starship = {
    enable = true;
    presets = [
      "pure"
    ];
  };
}
