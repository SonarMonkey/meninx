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

    # OBS Studio
    (pkgs.wrapOBS {
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-vaapi
        obs-nvfbc
        obs-vkcapture
        obs-gstreamer
        obs-backgroundremoval
        obs-pipewire-audio-capture
      ];
    })
  ];
}
