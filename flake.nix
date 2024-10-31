{
  description = "NixOS configuration with Home Manager";

  # Get inputs
  inputs = {
    # Packages
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nix-alien.url = "github:thiagokokada/nix-alien";

    # Package database
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hardware/software optimizations
    nix-gaming.url = "github:fufexan/nix-gaming";
    musnix.url = "github:musnix/musnix";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Replacement nix implementation
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

    # Disabled
    #niri.url = "github:sodiboo/niri-flake";
    #stylix.url = "github:danth/stylix";
    #nixvim.url = "github:nix-community/nixvim";
  };

  # Configure options passed to nix.conf
  nixConfig = {
    # Basic settings
    experimental-features = "nix-command flakes";
    auto-optimise-store = true;

    # Experimental settings
    accept-flake-config = true;

    # Trust users
    trusted-users = [
      "root"
      "sonar"
      "@wheel"
    ];

    # Binary caches
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://nix-gaming.cachix.org"
      "https://niri.cachix.org"
    ];
    extra-trusted-substituters = [
      "https://nix-community.cachix.org"
      "https://nix-gaming.cachix.org"
      "https://niri.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
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
    homeManagerModules = import ./modules/home-manager;

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

      # Prototype server configuration
      #thalamus = nixpkgs.lib.nixosSystem {
      #  system = "x86_64-linux";
      #  specialArgs = {inherit inputs outputs;};
      #  modules = [./nix/thalamus];
      #};

      # Main desktop configuration
      #cerebrum = nixpkgs.lib.nixosSystem {
      #  system = "x86_64-linux";
      #  specialArgs = {inherit inputs outputs;};
      #  modules = [./nix/cerebrum];
      #};
    };
  };
}
