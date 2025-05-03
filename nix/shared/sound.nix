{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  # Get the pipewire low-latency audio module from my flake
  imports = [
    inputs.nix-gaming.nixosModules.pipewireLowLatency
  ];

  # Install sound-related packages
  environment.systemPackages = with pkgs; [
    # Utilities
    helvum
    easyeffects
    carla

    # Audio production
    cardinal
    vcv-rack
    bespokesynth
    sunvox

    # Plugins
    lsp-plugins
  ];

  # Allow realtime per the NixOS wiki
  security.rtkit.enable = true;

  # Add user to "audio" group
  users.users.sonar.extraGroups = ["audio"];

  # Enable and configure pipewire
  services.pipewire = {
    enable = true;
    audio.enable = true;

    # Enable support for other systems
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    # Low-latency from nix-gaming
    lowLatency.enable = true;
  };
}
