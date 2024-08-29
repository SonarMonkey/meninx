{
  config,
  pkgs,
  inputs,
  ...
}: {
  specialisation.realtime.configuration = {
    # Get the audio modules from my flake
    imports = [
      inputs.musnix.nixosModules.musnix
    ];

    # Configure musnix for realtime
    musnix = {
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
