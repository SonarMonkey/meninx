{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Nix-index-database
  imports = [inputs.nix-index-database.hmModules.nix-index];

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
      on_force_close = "quit";
      simplified_ui = true;
      default_layout = "default";
      copy_command = "wl-copy";
      copy_on_select = true;
      pane_viewport_serialization = true;
      scrollback_lines_to_serialize = 0;
    };
  };

  # Zoxide
  programs.zoxide = {
    enable = true;
    options = ["--cmd cd"];
  };
}
