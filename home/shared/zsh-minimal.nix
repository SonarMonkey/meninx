{
  config,
  pkgs,
  ...
}: {
  # Install and configure zsh
  programs.zsh = {
    # Enable and basic settings
    enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
    autocd = true;
    autosuggestion.enable = true;

    # Increase histsize and configure
    history = {
      expireDuplicatesFirst = true;
      extended = true;
      save = "100000";
      size = "100000";
    };

    # Enable default substring search
    historySubstringSearch.enable = true;

    # Initialize batpipe and nh completions
    initExtra = ''
      eval "$(batpipe)"
      eval "$(nh completions -s zsh)"
    '';

    # Enable and configure default syntax highlighter
    syntaxHighlighting = {
      enable = true;
      highlighters = [
        "main"
        "brackets"
        "cursor"
      ];
    };
  };
}
