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
}
