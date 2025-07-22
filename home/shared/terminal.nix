{
  config,
  pkgs,
  ...
}: {
  # Home-manager specific configs
  home = {
    # Enable global shell integrations
    shell.enableShellIntegration = true;

    # Global home-manager envvars
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      QT_QPA_PLATFORM = "wayland";
      EDITOR = "hx";
      VISUAL = "neovide";
      NEOVIM_BIN = "lvim";
    };

    # Global shell aliases
    shellAliases = {
      # Editor stuff
      e = "$EDITOR";
      se = "sudo $EDITOR";
      vi = "lvim";
      vim = "lvim";
      nvim = "lvim";
      nv = "lvim";
      wg = "wordgrinder";

      # Mullvad
      mu = "mullvad";
      mus = "mullvad status";
      mup = "mullvad connect";
      mur = "mullvad reconnect";
      mud = "mullvad disconnect";
      mue = "mullvad-exclude";
    };
  };

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

    # Shell-specific aliases (duplicated in zsh and fish)
    shellAliases = {
      # nixOS
      nfm = "nix fmt && git commit -a -m \"Format with Alejandra\"";
      fup = "nix flake --refresh update --commit-lock-file";
      fch = "nix flake check";
      nup = "sudo nixos-rebuild switch -v";
      nbo = "sudo nixos-rebuild boot -v";
      gcol = "sudo nix-collect-garbage -d";
      nopt = "sudo nix-store -j 8 -vv --optimise";

      # Nix-helper
      switch = "nh os switch --ask";
      boot = "nh os boot --ask";
      search = "nh search";
      clean = "nh clean all -k 5";
      ntest = "nh os test --ask";
    };
  };
}
