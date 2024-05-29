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

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    # General utilities
    fd
    fzf
    gcc
    genact
    gh
    git
    jq
    yq
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

    # Leave some java laying around
    adoptopenjdk-bin
    nodejs

    # Explicitly install NTFS drivers
    ntfs3g
  ];
}
