{
  config,
  pkgs,
  ...
}: {
  # Home-manager specific configs
  home = {
    # Global home-manager envvars
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      EDITOR = "lvim";
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

      # Mullvad
      mu = "mullvad";
      mus = "mullvad status";
      mup = "mullvad connect";
      mur = "mullvad reconnect";
      mud = "mullvad disconnect";
      mue = "mullvad-exclude";

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
  };
}
