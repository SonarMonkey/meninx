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

    # Initialize batpipe and nh completions
    initExtra = ''
      eval "$(batpipe)"
      eval "$(nh completions -s zsh)"
    '';

    # Session variables for ZSH
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

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
