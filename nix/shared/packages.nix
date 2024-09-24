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
      inputs.nix-vscode-extensions.overlays.default
      outputs.overlays.additions
    ];
  };

  # Make sure to install extra outputs
  environment.extraOutputsToInstall = [
    "info"
    "man"
    "doc"
  ];

  # Enable nix-ld
  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
  };

  # Allow running appimages
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    # General utilities
    bat
    bottom
    fd
    fzf
    gcc
    gh
    git
    jq
    yq
    ookla-speedtest
    pandoc
    qmk
    ripgrep
    ripgrep-all
    suckit
    skim
    unzip
    ventoy-full
    wl-clipboard
    nodePackages.prettier
    libheif
    pciutils
    yt-dlp
    ffmpeg-full
    appimage-run

    # Desktop applications
    gimp-with-plugins
    inkscape-with-extensions
    krita
    libreoffice-fresh
    scribus
    vlc

    # Nix-related utilities
    inputs.nix-alien.packages.x86_64-linux.nix-alien
    alejandra
    nix-init
    nixfmt-rfc-style
    nurl
    nixd

    # Explicitly install NTFS drivers
    ntfs3g

    # Other programming language tools
    nodejs
    temurin-bin
    go
    gopls
    go-tools
    delve
    codeium
    libclang
    python3Full
  ];
}
