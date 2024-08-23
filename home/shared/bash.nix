{
  config,
  pkgs,
  ...
}: {
  # Configure bash
  programs.bash = {
    # Basic settings
    enable = true;
    enableCompletion = true;
    enableVteIntegration = true;

    # Fancy stuff
    initExtra = ''
      eval "$(nh completions -s bash)"
    '';
  };
}
