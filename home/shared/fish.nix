{
  config,
  pkgs,
  ...
}: {
  # Install and configure fish
  programs.fish = {
    # Enable and basic settings
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
    '';
  };
}
