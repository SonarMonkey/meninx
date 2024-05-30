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
    adwsteamgtk
    bottles
    heynote
    libreoffice-fresh
    mediawriter
    obsidian
    pika-backup
    thunderbird
    transmission_4-gtk
    vesktop
    zed-editor
  ];
}
