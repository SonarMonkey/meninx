{
  config,
  pkgs,
  ...
}: {
  # Enable and basic options for fish
  programs.fish = {
    enable = true;
    useBabelfish = true;
  };

  # Disable mancaches for faster build
  documentation.man.generateCaches = false;
}
