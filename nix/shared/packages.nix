{
  config,
  pkgs,
  inputs,
  outputs,
  ...
}: {
  # Enable non-free packages and overlays
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      inputs.nur.overlay
      outputs.overlays.additions
    ];
  };

  # Pre-built index of nixpkgs and tool to run them
  imports = [inputs.nix-index-database.nixosModules.nix-index];
  programs.nix-index.enable = true;
  programs.nix-index-database.comma.enable = true;
  programs.command-not-found.enable = false;

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    # General utilities
    gcc
    git
    unzip
    fzf
    ripgrep
    ripgrep-all
    wl-clipboard
    suckit
    ookla-speedtest
    qmk
    fzf
    ventoy-full
    genact
    jq
    moreutils
    gh

    # Desktop applications
    gimp-with-plugins
    inkscape-with-extensions
    libreoffice-fresh
    krita
    scribus
    vlc
    github-desktop
    zed

    # Nix-related utilities
    alejandra
    deadnix
    nixfmt-rfc-style
    nurl
    nix-init
    inputs.nh.packages.x86_64-linux.default

    # Fonts
    maple-mono-NF
    inter
    corefonts
    nerdfonts

    # Leave some java laying around
    adoptopenjdk-bin
    nodejs

    # Explicitly install NTFS drivers
    ntfs3g
  ];
}
