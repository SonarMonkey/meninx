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
    inputs.musnix.nixosModules.musnix
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

  # Not sure but this is from https://wiki.nixos.org/wiki/JACK
  security.sudo.extraConfig = ''
    sonar ALL=(ALL) NOPASSWD: ${pkgs.systemd}/bin/systemctl
  '';

  # Allow realtime per the NixOS wiki
  security.rtkit.enable = true;

  # Add user to "audio" group
  users.users.sonar.extraGroups = ["audio"];

  # Disable pulseaudio in favor of pipewire
  hardware.pulseaudio.enable = false;

  # Enable and configure musnix
  musnix = {
    # Basic settings
    enable = true;
    soundcardPciId = "00:1f.3";
    alsaSeq.enable = false;
    rtcqs.enable = true;
  };

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
