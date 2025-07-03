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

    # Games
    blightmud
    gnome-sudoku
    mudlet

    # FIXME Disabled for some lxml failure
    #gnome-feeds
  ];
}
