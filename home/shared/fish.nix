{
  config,
  pkgs,
  ...
}: {
  # Install and configure fish
  programs.fish = {
    # Enable and basic settings
    enable = true;

    # Disable greeting
    interactiveShellInit = ''
      set fish_greeting
    '';

    # Use programs-configured aliases as abbrs
    preferAbbrs = true;

    # Shell aliases (dupe of bash.shellAliases)
    shellAbbrs = config.programs.bash.shellAliases;
  };
}
