{
  config,
  pkgs,
  ...
}: {
  # Permit all shells for user accounts
  #environment.shells = with pkgs; [zsh];

  # Set default shell to zsh
  #users.defaultUserShell = pkgs.zsh;

  # Enable and basic options for zsh
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
  };

  # Ensure completion is available to zsh
  environment.pathsToLink = [
    "/share/zsh"
  ];
}
