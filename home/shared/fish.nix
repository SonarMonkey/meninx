{
  config,
  pkgs,
  ...
}: {
  # Install and configure fish
  programs.fish = {
    # Enable and basic settings
    enable = true;

    # Interactive shell init
    interactiveShellInit = ''
      set fish_greeting
      fish_config theme choose "Base16 Default Dark"
    '';

    # Use programs-configured aliases as abbrs
    preferAbbrs = true;

    # Shell aliases (dupe of bash.shellAliases)
    shellAbbrs = config.programs.bash.shellAliases;
  };
}
