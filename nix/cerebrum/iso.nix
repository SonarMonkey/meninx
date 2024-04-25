{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  # Import external modules
  imports = [
    inputs.disko.nixosModules.disko
    inputs.agenix.nixosModules.default
  ];

  # Set the custom ISO edition
  isoImage.edition = "nvidia-kde6";

  # Configure nix
  nix = {
    # Use flake enable nix package
    package = pkgs.nixFlakes;

    # Further configuration
    settings = {
      # Enable flakes
      experimental-features = "nix-command flakes";

      # Cachix binary caches
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

      # Trust installer users by default
      trusted-users = [
        "root"
        "nixos"
        "@wheel"
      ];
    };
  };

  # Allow non-free and CUDA packages
  nixpkgs.config = {
    allowUnfree = true;
    cudaSupport = true;
  };

  # Enable KDE Plasma 6
  services.desktopManager.plasma6.enable = true;

  # Enable SDDM and automatically login as nixos
  services.displayManager = {
    sddm.enable = true;
    autoLogin = {
      enable = true;
      user = "nixos";
    };
  };

  # Add some necessary packages
  environment.systemPackages = with pkgs; [
    git
    helix
    inputs.agenix.packages.x86_64-linux.default
  ];

  # Configure boot
  boot = {
    kernelPackages = lib.mkOverride 0 pkgs.linuxPackages_xanmod_latest;
    initrd.kernelModules = ["nvidia"];
    extraModulePackages = [config.boot.kernelPackages.nvidia_x11];
  };

  # Explicitly set x-server drivers
  services.xserver.videoDrivers = ["nvidia"];

  # Enable SSH from encephalon in the boot process
  systemd.services.sshd.wantedBy = pkgs.lib.mkForce ["multi-user.target"];
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMTH4iKtY6k9t/WVtHG0S4SuVJIA+nAb3nC5NNS2M28x sonar@encephalon"
  ];

  # Hardware configuration
  hardware = {
    # Enable openGL
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        vaapiVdpau
      ];
    };

    # Nvidia settings
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
    };
  };
}
