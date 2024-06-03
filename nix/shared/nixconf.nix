{
  config,
  pkgs,
  ...
}: {
  # Set the initially-installed version
  system.stateVersion = "24.05";

  # Enable `nix` and flakes
  nix = {
    package = pkgs.nixFlakes;
    settings = {
      # Enable flakes
      experimental-features = "nix-command flakes";

      # Automatically optimise the nix store
      auto-optimise-store = true;

      # Experimental settings
      accept-flake-config = true;

      # Cachix package caches
      extra-substituters = [
        "https://nix-community.cachix.org"
        "https://nix-gaming.cachix.org"
      ];
      extra-trusted-substituters = [
        "https://nix-community.cachix.org"
        "https://nix-gaming.cachix.org"
      ];
      extra-trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      ];
    };

    # Automatic garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # Enable and configure `nh` helper
  programs.nh = {
    enable = true;
    flake = "/etc/nixos";
    clean = {
      enable = true;
      extraArge = "--keep 5";
    };
  };
}
