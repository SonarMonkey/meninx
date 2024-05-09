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

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    # General utilities
    espanso-wayland
    fd
    fzf
    fzf
    gcc
    genact
    gh
    git
    jq
    moreutils
    ookla-speedtest
    pandoc
    qmk
    ripgrep
    ripgrep-all
    suckit
    unzip
    ventoy-full
    wl-clipboard
    nodePackages.prettier

    # Desktop applications
    gimp-with-plugins
    inkscape-with-extensions
    krita
    libreoffice-fresh
    scribus
    vlc

    # Nix-related utilities
    alejandra
    deadnix
    inputs.nh.packages.x86_64-linux.default
    nix-init
    nixfmt-rfc-style
    nurl

    # Fonts
    corefonts
    inter
    maple-mono-NF
    nerdfonts

    # Leave some java laying around
    adoptopenjdk-bin
    nodejs

    # Explicitly install NTFS drivers
    ntfs3g
  ];
}
