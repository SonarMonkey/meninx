{
  config,
  pkgs,
  ...
}: {
  # Show password feedback on sudo
  security.sudo.extraConfig = "Defaults pwfeedback";

  # Permit all shells for user accounts
  environment.shells = with pkgs; [bashInteractive zsh];

  # Tune up bash a little
  programs.bash = {
    # Defaults
    enableCompletion = true;
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

  # Make sure completions paths are linked up
  environment.pathsToLink = [
    "/share/zsh"
    "/share/bash-completion"
  ];
}
