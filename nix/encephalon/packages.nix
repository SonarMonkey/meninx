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

    # Themes
    adwsteamgtk
    adw-gtk3

    # Desktop applications
    vesktop
    thunderbird
    libreoffice-fresh
    logseq
    pika-backup
    bottles
    mediawriter
    adwsteamgtk
    transmission_4-gtk
    obsidian
    heynote
    nb
  ];
}
