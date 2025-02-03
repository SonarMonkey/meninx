{
  config,
  lib,
  pkgs,
  ...
}: {
  # Encephalon-specific packages
  environment.systemPackages = with pkgs; [
    # Tools
    dconf2nix
    zola
    lunarvim
    neovide
    wordgrinder

    # Desktop applications
    bottles
    heynote
    komikku
    libreoffice-fresh
    mediawriter
    obsidian
    pika-backup
    textpieces
    thunderbird
    transmission_4-gtk
    switcheroo
    vesktop
    gnome-feeds
    arduino-ide
    protonvpn-gui

    # Games
    blightmud
    gnome-sudoku
    mudlet
  ];
}
