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
    arduino-ide
    legcord
    openscad
    freecad
    blender
    gnome-boxes
    gnome-tweaks
    gnome-feeds

    # Games
    blightmud
    gnome-sudoku
    mudlet
  ];
}
