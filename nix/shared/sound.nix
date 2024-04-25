{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Get the low-latency module from nix-gaming
  imports = [inputs.nix-gaming.nixosModules.pipewireLowLatency];

  # Enable sound
  sound.enable = true;

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
    lowLatency.enable = true;
  };
}
