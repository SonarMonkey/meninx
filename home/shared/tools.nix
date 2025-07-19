{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Nix-index-database
  imports = [inputs.nix-index-database.homeModules.nix-index];

  # Command-not-found // nix-index
  programs.nix-index = {
    enable = true;
    symlinkToCacheHome = true;
  };

  # Comma with nix-index-db
  programs.nix-index-database.comma.enable = true;

  # Bat
  programs.bat.enable = true;

  # Lazygit (mostly for LunarVim)
  programs.lazygit.enable = true;

  # Eza
  programs.eza = {
    enable = true;
    extraOptions = ["--group-directories-first"];
  };

  # Git
  programs.git = {
    enable = true;
    delta.enable = true;
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
      editor = "e";
    };
  };

  # Neovide
  programs.neovide = {
    enable = true;

    # General startup settings
    settings = {
      fork = true;
      frame = "full";
      idle = true;
      maximized = true;
      neovim-bin = "${pkgs.lunarvim}/bin/lvim";
      tabs = false;
      theme = "auto";
      vsync = true;
      wsl = false;

      # Font configuration
      font = {
        normal = ["Maple Mono NF"];
        size = 12.0;
      };
    };
  };

  # Helix
  programs.helix = {
    enable = true;
  };

  # Yazi
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  # Zoxide
  programs.zoxide = {
    enable = true;
    options = ["--cmd cd"];
  };
}
