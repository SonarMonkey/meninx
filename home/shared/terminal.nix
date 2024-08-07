{
  config,
  pkgs,
  ...
}: {
  # Home-manager specific configs
  home = {
    # Global home-manager envvars
    sessionVariables = {
      NIXOS_OZONE_WL = 1;
    };

    # Global shell aliases
    shellAliases = {
      # General stuff
      e = "$EDITOR";
      se = "sudo $EDITOR";
      h = "hx";
      nv = "neovim";
      ns = "nix-env -qa | fzf";
      s = "kitten ssh";

      # Mullvad
      mu = "mullvad";
      mus = "mullvad status";
      mup = "mullvad connect";
      mur = "mullvad reconnect";
      mud = "mullvad disconnect";
      mue = "mullvad-exclude";

      # Nix configs
      ne = "e ~/Nix/";
      nc = "e ~/Nix/configuration.nix";
      ndot = "e ~/Nix/nix.d/";
      he = "e ~/Nix/home.nix";
      hdot = "e ~/Nix/home.d/";

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
    };
  };
}
