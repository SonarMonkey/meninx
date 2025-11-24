{
  config,
  pkgs,
  ...
}: {
  # Install and configure fish
  programs.fish = {
    # Enable and basic settings
    enable = true;

    # Config and conveniences
    interactiveShellInit = ''
      set fish_greeting
      # batman --export-env | source
      # eval (batpipe)
      eval (nh completions fish)
    '';

    # Use programs-configured aliases as abbrs
    preferAbbrs = true;

    # Shell aliases (dupe of bash.shellAliases)
    shellAbbrs = config.programs.bash.shellAliases;
  };
}
