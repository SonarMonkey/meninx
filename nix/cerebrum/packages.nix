{
  config,
  lib,
  pkgs,
  ...
}: {
  # Cerebrum-specific packages
  environment.systemPackages = with pkgs; [
    # Tools
    betterdiscordctl

    # Desktop applications
    (blender.override {cudaSupport = true;})
    gwe
    qbittorrent

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
