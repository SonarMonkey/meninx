{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Get the low-latency module from nix-gaming
  imports = [
    inputs.nix-gaming.nixosModules.pipewireLowLatency
    inputs.musnix.nixosModules.musnix
  ];

  # Configure musnix for better audio
  musnix = {
    enable = true;
    soundcardPciId = "00:1f.3";
  };

  # Disable pulseaudio in favor of pipewire
  hardware.pulseaudio.enable = false;

  # Allow realtime
  security.rtkit.enable = true;

  # Enable and configure pipewire
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    # May conflict with musnix?
    lowLatency.enable = true;
  };
}
