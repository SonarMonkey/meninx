{
  config,
  pkgs,
  inputs,
  ...
}: {
  specialisation.realtime.configuration = {
    # Get the audio modules from my flake
    imports = [
      inputs.nix-gaming.nixosModules.pipewireLowLatency
      inputs.musnix.nixosModules.musnix
    ];

    # Not sure but this is from https://wiki.nixos.org/wiki/JACK
    security.sudo.extraConfig = ''
      sonar ALL=(ALL) NOPASSWD: ${pkgs.systemd}/bin/systemctl
    '';

    # Additional pipewire config
    services.pipewire = {
      jack.enable = true;
      lowLatency.enable = false;
    };

    # Install extra jack-related packages
    environment.systemPackages = with pkgs; [
      pavucontrol
      libjack2
      jack2
      qjackctl
      jack2Full
      jack_capture
      carla
    ];

    # Configure musnix
    musnix = {
      # Basic settings
      enable = true;
      soundcardPciId = "00:1f.3";
      alsaSeq.enable = false;
      rtcqs.enable = true;

      # Enable realtime kernel
      kernel = {
        realtime = true;
        packages = pkgs.linuxPackages_latest_rt;
      };

      # Also not sure, taken from https://wiki.nixos.org/wiki/JACK
      rtirq = {
        enable = true;
        # highList = "snd_hrtimer";
        resetAll = 1;
        prioLow = 0;
        nameList = "rtc0 snd";
      };
    };
  };
}
