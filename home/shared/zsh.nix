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

    # Enable and configure autosuggest
    autosuggestion = {
      enable = true;
      strategy = [
        "history"
        "completion"
      ];
    };

    # Increase histsize and configure
    history = {
      extended = true;
      save = 100000;
      size = 100000;
    };

    # Enable default substring search
    historySubstringSearch.enable = true;

    # Initialize nh completions
    initContent = ''
      eval "$(nh completions zsh)"
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

    # Shell aliases (dupe of bash.shellAliases)
    shellAliases = config.programs.bash.shellAliases;
  };
}
