{
  config,
  pkgs,
  ...
}: {
  # Configure zsh + prezto
  programs.zsh = {
    # Basic settings
    enable = true;
    autocd = true;

    # Completions and fancy pipe
    initExtra = ''
      eval "$(batpipe)"
      eval "$(nh completions -s zsh)"
    '';

    # Session variables for ZSH
    sessionVariables = {
      FLAKE = "/home/sonar/Nix";
      NIXOS_OZONE_WL = "1";
    };

    # Shell aliases
    shellAliases = {
      # General stuff
      e = "$EDITOR";
      se = "sudo $EDITOR";
      h = "hx";
      ns = "nix-env -qa | fzf";
      s = "kitten ssh";

      # Tailscale
      ts = "tailscale";
      tss = "tailscale status";
      tnet = "tailscale netcheck";
      trec = "tailscale down && tailscale up --ssh --operator=sonar";
      tre = "sudo systemctl restart tailscaled.service systemd-resolved.service";

      # Tailscale VPN-specific
      vpndown = "tailscale set --exit-node ''";
      vpnden = "tailscale set --exit-node '100.120.178.99'";
      vpnse = "tailscale set --exit-node '100.127.8.7'";

      # Mullvad
      mu = "mullvad";
      mus = "mullvad status";
      mup = "mullvad connect";
      mur = "mullvad reconnect";
      mud = "mullvad disconnect";
      mue = "mullvad-exclude";

      # Doom Emacs
      dup = "doom upgrade";
      dsup = "doom sync -up";
      ddoc = "doom doctor";
      dre = "doom build -r";
      dcl = "doom clean && doom purge && doom purge -g";

      # Nix configs
      ne = "e ~/Nix/";
      nc = "e ~/Nix/configuration.nix";
      ndot = "e ~/Nix/nix.d/";
      he = "e ~/Nix/home.nix";
      hdot = "e ~/Nix/home.d/";

      # nixOS
      nfm = "nix fmt && git -a -m \"Format with Alejandra\"";
      fup = "nix flake update && git -a -m \"Update flake inputs\"";
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

    # Prezto config
    prezto = {
      enable = true;

      # Editor configuration
      editor = {
        dotExpansion = true;
        keymap = "vi";
        promptContext = true;
      };

      # Modules to load
      pmodules = [
        "environment" # must be loaded first
        "archive" # must come before "completion"
        "editor" # not sure what this is
        "git" # must come before "completion"
        "history" # maybe not necessary? needs addl. config
        "syntax-highlighting" # not sure if redundant
        "history-substring-search" # must be loaded after "syntax-highlighting"
        "autosuggestions" # must before loaded after "syntax-highlighting" and "history-substring-search"
        "prompt" # just for themes? needs addl. config
        "spectrum" # improves 256-color support
        "utility" # must be loaded before "completion"
        "completion" # must be loaded after "utility"
      ];
    };
  };
}
