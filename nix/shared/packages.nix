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
      inputs.nur.overlays.default
      inputs.nix-vscode-extensions.overlays.default
      outputs.overlays.additions
    ];
  };

  # Enable nix-ld
  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld;
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
    gh
    git
    lazygit
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
    gcc
    nodePackages.prettier
    nodejs
    temurin-bin
    go
    gopls
    go-tools
    delve
    libclang
    python3Full
  ];
}
