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

    # Themes
    adwsteamgtk
    adw-gtk3

    # Desktop applications
    adwsteamgtk
    aseprite
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
    bitwarden-desktop
    gnome-feeds
    arduino-ide
    kicad

    # Games
    blightmud
    gnome-sudoku
    mudlet
  ];
}
