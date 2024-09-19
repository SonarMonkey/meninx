{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.hardware.pyClock;
in {
  options.hardware.pyClock = {
    # Enable
    enable = mkEnableOption "Enable overclocking of Nvidia cards";

    # GPU device by index
    gpuDevice = mkOption {
      type = types.int;
      default = "0";
      description = "Select GPU device to overclock by index";
    };

    # GPU clock offset
    clockOffset = mkOption {
      type = types.int;
      default = "0";
      description = "Set the GPU clock offset in MHz";
    };

    # GPU memory clock offset
    memOffset = mkOption {
      type = types.int;
      default = "0";
      description = "Set the memory clock offset in MHz";
    };

    # GPU power limit
    powerLimit = mkOption {
      type = types.int;
      description = "Set the GPU power limit in mW";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      (pkgs.writers.writePython3Bin "apply-oc" {
          libraries = [pkgs.python3Packages.nvidia-ml-py];
          flakeIgnore = ["F403" "F405"];
        }
        ''
          from pynvml import *
          nvmlInit()
          myGPU = nvmlDeviceGetHandleByIndex(${toString cfg.gpuDevice})
          nvmlDeviceSetGpcClkVfOffset(myGPU, ${toString cfg.clockOffset})
          nvmlDeviceSetMemClkVfOffset(myGPU, ${toString cfg.memOffset})
          nvmlDeviceSetPowerManagementLimit(myGPU, ${toString cfg.powerLimit})
        '')
    ];
  };
}
