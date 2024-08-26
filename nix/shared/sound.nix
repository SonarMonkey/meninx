{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Get the audio modules from my flake
  imports = [
    inputs.nix-gaming.nixosModules.pipewireLowLatency
    inputs.musnix.nixosModules.musnix
  ];

  # Define real-time specialisation
  specialisation.realtime.configuration = {
    musnix = {
      rtcqs.enable = true;
      rtirq.enable = true;
      kernel = {
        realtime = true;
        packages = pkgs.linuxPackages_latest_rt;
      };
    };
  };

  # Add user to "audio" group
  users.users.sonar.extraGroups = ["audio"];

  # Configure musnix for better audio support
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

    # Enable support for other systems
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    # Low-latency from nix-gaming
    lowLatency.enable = true;
  };
}
