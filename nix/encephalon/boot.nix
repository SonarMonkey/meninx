{
  config,
  pkgs,
  lib,
  ...
}: {
  # Configure generic boot settings
  boot = {
    # Use the latest linux-lqx kernel
    kernelPackages = lib.mkDefault pkgs.linuxPackages_xanmod_latest;

    # Enable mutable efivars
    loader.efi.canTouchEfiVariables = true;

    # Use systemd-boot as bootloader
    loader.systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };
  };

  # Configure kmscon to replace getty
  services.kmscon = {
    enable = true;
    hwRender = true;
    useXkbConfig = true;
    fonts = [
      {
        name = "Cozette";
        package = pkgs.cozette;
      }
    ];
    extraConfig = ''
      palette=custom
      palette-black=0,43,54
      palette-red=220,50,47
      palette-green=133,153,0
      palette-yellow=181,137,0
      palette-blue=38,139,210
      palette-magenta=108,113,196
      palette-cyan=42,161,152
      palette-light-grey=147,161,161
      palette-dark-grey=101,123,131
      palette-light-red=220,50,47
      palette-light-green=133,153,0
      palette-light-yellow=181,137,0
      palette-light-blue=38,139,210
      palette-light-magenta=108,113,196
      palette-light-cyan=42,161,152
      palette-white=253,246,227
      palette-foreground=147,161,161
      palette-background=0,43,54
    '';
  };
}
