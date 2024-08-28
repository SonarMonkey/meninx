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

  # Install sound-related packages
  environment.systemPackages = with pkgs; [
    # Utilities
    helvum
    easyeffects

    # Audio production
    cardinal
    vcv-rack
    bespokesynth
    sunvox

    # Plugins
    lsp-plugins
    tunefish
    bankstown-lv2
    chow-tape-model
    chow-kick
    chow-centaur
    chow-phaser
  ];

  # Add user to "audio" group
  users.users.sonar.extraGroups = ["audio"];

  # Configure musnix for better audio support
  musnix = {
    enable = true;
    soundcardPciId = "00:1f.3";
    rtcqs.enable = true;
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
