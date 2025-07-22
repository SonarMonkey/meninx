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

  # Plugins to install from nixpkgs
  environment.systemPackages = with pkgs.fishPlugins; [
    pure
  ];

  # Disable mancaches for faster build
  documentation.man.generateCaches = false;
}
