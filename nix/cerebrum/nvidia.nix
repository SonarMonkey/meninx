{
  config,
  lib,
  pkgs,
  ...
}: {
  # Load the Nvidia kernel drivers
  boot = {
    extraModulePackages = [config.boot.kernelPackages.nvidia_x11];
    initrd.kernelModules = ["nvidia"];
  };

  # Enable CUDA support in nixpkgs
  nixpkgs.config.cudaSupport = true;

  # Enable X with Nvidia drivers and overclocking
  services.xserver = {
    # Basic settings
    enable = true;
    videoDrivers = ["nvidia"];

    # Enable overclocking and such for nvidia
    deviceSection = lib.mkAfter ''
      Option          "Coolbits" "31"
    '';
  };

  # Nvidia-specific hardware settings
  hardware = {
    # Nvidia settings
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
    };

    # OpenGL for Nvidia
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        vaapiVdpau
      ];
    };
  };
}
