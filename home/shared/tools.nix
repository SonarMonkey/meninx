{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Nix-index-database
  imports = [inputs.nix-index-database.hmModules.nix-index];

  # Bat
  programs.bat.enable = true;

  # Bottom
  programs.bottom.enable = true;

  # Command-not-found // nix-index
  programs.nix-index = {
    enable = true;
    symlinkToCacheHome = true;
  };

  # Comma with nix-index-db
  programs.nix-index-database.comma.enable = true;

  # Eza
  programs.eza = {
    enable = true;
    extraOptions = ["--group-directories-first"];
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
    enableBashIntegration = true;
    enableZshIntegration = true;
    settings = {
      manager = {
        show_hidden = true;
        sort_by = "modified";
        sort_dir_first = true;
        sort_reverse = true;
      };
    };
  };

  # Zellij
  programs.zellij = {
    enable = true;
    settings = {
      theme = "solarized-dark";
    };
  };

  # Zoxide
  programs.zoxide = {
    enable = true;
    options = ["--cmd cd"];
  };
}
