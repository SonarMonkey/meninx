{
  config,
  pkgs,
  ...
}: {
  # Path configuration
  environment.localBinInPath = true;

  # Global environment variables
  environment.variables = {
    FLAKE = "/home/sonar/Nix";
    NIXOS_OZONE_WL = "1";
  };

  # Global shell aliases
  environment.shellAliases = {
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

    # Nix configs
    ne = "e ~/Nix/";
    nc = "e ~/Nix/configuration.nix";
    ndot = "e ~/Nix/nix.d/";
    he = "e ~/Nix/home.nix";
    hdot = "e ~/Nix/home.d/";

    # nixOS
    nfm = "nix fmt && git ca \"Format with Alejandra\"";
    fup = "nix flake update && git ca \"Update flake inputs\"";
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
}
