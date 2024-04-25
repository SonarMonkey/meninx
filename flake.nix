{
  description = "NixOS configuration with Home Manager";

  # Get inputs
  inputs = {
    # Packages
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";

    # Index of packages
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Run unpatched binaries
    nix-alien.url = "github:thiagokokada/nix-alien";

    # Better setup instead of whole NUR
    # TODO switch to using this for firefox addons
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Gaming optimizations
    nix-gaming.url = "github:fufexan/nix-gaming";

    # Pre-defined hardware configs
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Declarative partition setup
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Secrets
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Neat nix-helper tool
    nh = {
      url = "github:viperML/nh";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Pre-configured themes
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Configure options passed to nix.conf
  nixConfig = {
    # Basic settings
    experimental-features = "nix-command flakes";
    auto-optimise-store = true;

    # Experimental settings
    accept-flake-config = true;

    # Binary caches
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://nix-gaming.cachix.org"
      "https://cuda-maintainers.cachix.org"
    ];
    extra-trusted-substituters = [
      "https://nix-community.cachix.org"
      "https://nix-gaming.cachix.org"
      "https://cuda-maintainers.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
    ];
  };

  # Configure outputs
  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    # Use `alejandra` as the system formatter (via `nix fmt`)
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;

    # Reusable nixos modules
    nixosModules = import ./modules/nixos;

    # Reusable home-manager modules
    hmModules = import ./modules/home-manager;

    # My local custom packages and modifications
    overlays = import ./overlays {inherit inputs;};

    # Define NixOS configuration(s)
    nixosConfigurations = {
      # Main laptop configuration
      encephalon = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs outputs;};
        modules = [./nix/encephalon];
      };

      # Main desktop configuration
      cerebrum = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs outputs;};
        modules = [./nix/cerebrum];
      };

      # Custom `.iso` for desktop
      nvidia-kde6 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs outputs;};
        modules = [
          "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-base.nix"
          ./nix/cerebrum/iso.nix
        ];
      };
    };
  };
}
