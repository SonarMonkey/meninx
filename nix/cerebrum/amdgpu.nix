{
  config,
  pkgs,
  ...
}: {
  # Most settings copied directly from https://wiki.nixos.org/wiki/AMD_GPU
  # TODO add OC tool (tuxclocker, corectrl, lact)
  # TODO add HIP/etc. packages
  # TODO consider https://github.com/nixos-rocm/nixos-rocm

  # Load the AMD kernel drivers
  boot.initrd.kernelModules = ["amdgpu"];

  # Enable ROCM support in nixpkgs
  nixpkgs.config.rocmSupport = true;

  # Make sure the X server uses correct driver
  services.xserver = {
    enable = true;
    videoDrivers = ["modesetting"];
  };

  # Override hard-coded HIP libraries
  # FIXME I do not know what this means
  # See https://wiki.nixos.org/wiki/AMD_GPU#HIP
  systemd.tmpfiles.rules = let
    rocmEnv = pkgs.symlinkJoin {
      name = "rocm-combined";
      paths = with pkgs.rocmPackages; [
        rocblas
        hipblas
        clr
      ];
    };
  in [
    "L+    /opt/rocm   -    -    -     -    ${rocmEnv}"
  ];

  # Configure OpenGL
  hardware.opengl = {
    enable = true; # Enabled by default I think
    driSupport = true; # This is already enabled by default
    driSupport32Bit = true; # For 32 bit applications

    # Enable OpenCL and add AMDVLK drivers in addition to RADV
    extraPackages = with pkgs; [
      rocmPackages.clr
      rocmPackages.clr.icd
      amdvlk
    ];
    extraPackages32 = with pkgs; [
      driversi686Linux.amdvlk
    ];
  };

  # And workaround for my Polaris card
  # See https://wiki.nixos.org/wiki/AMD_GPU#OpenCL
  environment.variables = {
    ROC_ENABLE_PRE_VEGA = "1";
  };
}
