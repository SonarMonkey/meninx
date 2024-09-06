{
  config,
  pkgs,
  inputs,
  outputs,
  lib,
  ...
}: {
  # Set up bootloader
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };

  # Set system hostname
  networking.hostName = "thalamus";

  # Enable and configure `nix` and flakes
  nix = {
    package = pkgs.nixFlakes;

    # Configure nix
    settings = {
      # Enable flakes
      experimental-features = "nix-command flakes";

      # Automatically optimise the nix store
      auto-optimise-store = true;

      # Experimental settings
      accept-flake-config = true;

      # Allow admin trusted access
      trusted-users = ["admin"];

      # Cachix package caches
      extra-substituters = [
        "https://nix-community.cachix.org"
      ];
      extra-trusted-substituters = [
        "https://nix-community.cachix.org"
      ];
      extra-trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };

    # Enable garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      persistent = true;
    };
  };

  # Enable non-free packages and overlays
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [outputs.overlays.additions];
  };

  # Set the system time zone
  time.timeZone = "America/Denver";

  # Select internationalisation options
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  # Configure users
  users = {
    mutableUsers = false;

    users.admin = {
      isNormalUser = true;
      description = "Thalamus Admin";
      extraGroups = ["wheel"];
      initialHashedPassword = "$y$j9T$ztfM87i15eONyJZGHkY2F0$2gwb9S./jXc8B5ZE4RMyBPXouC9UBik/sGz4qhFAVq3";
      hashedPasswordFile = config.age.secrets.admin.path;
    };
  };

  # Set global environment variables TODO shellaliases
  environment.variables.FLAKE = "/etc/nixos";

  # Install packages TODO add charm flake
  environment.systemPackages = with pkgs; [
    # General tools
    alejandra
    helix
    neovim
    bat
    fd
    fzf
    ripgrep
    pciutils
    git
    bottom

    # Server packages
    wastebin
    soft-serve
    jellyfin
    seafile-server
    cloudflared
  ];

  # Configure programs TODO git aliases
  programs = {
    nh = {
      enable = true;
      flake = "/etc/nixos";
    };
  };

  # Configure system services
  services = {
    # General basics
    fwupd.enable = true;

    # Filesystem maintenance FIXME
    btrfs.autoScrub = {
      enable = true;
      fileSystems = ["/"];
      interval = "monthly";
    };
  };

  # Set the initially-installed version
  system.stateVersion = "24.05";
}
