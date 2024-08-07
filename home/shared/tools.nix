{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Bat
  programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [
      prettybat
      batwatch
      batpipe
      batman
      batgrep
      batdiff
    ];
  };

  # Bottom
  programs.bottom.enable = true;

  # Command-not-found
  programs.command-not-found.enable = true;

  # Eza
  programs.eza = {
    enable = true;
    git = true;
    icons = true;
    extraOptions = [
      "--group-directories-first"
      "--header"
    ];
  };

  # Git
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;

    # User settings
    userEmail = "12001125+SonarMonkey@users.noreply.github.com";
    userName = "SonarMonkey";

    # Configure aliases
    aliases = {
      aa = "add -A";
      pu = "push -u origin main";
      cm = "commit -m";
      ca = "commit -a -m";
      st = "status";
    };
  };

  # GitHub CLI
  programs.gh = {
    enable = true;

    # Add extensions (probably don't need these)
    #extensions = [pkgs.gh-f pkgs.gh-eco pkgs.gh-dash];

    # Credential helper (defaults)
    gitCredentialHelper = {
      enable = true;
      hosts = [
        "https://github.com"
        "https://gist.github.com"
      ];
    };

    # Configure
    settings = {
      git_protocol = "ssh";
      editor = "hx";
    };
  };

  # Starship prompt
  programs.starship = {
    enable = true;
  };

  # Yazi
  programs.yazi = {
    enable = true;
    settings = {
      manager = {
        show_hidden = true;
        sort_by = "modified";
        sort_dir_first = true;
        sort_reverse = true;
      };
    };
  };

  # Zoxide
  programs.zoxide = {
    enable = true;
    options = ["--cmd cd"];
  };
}
