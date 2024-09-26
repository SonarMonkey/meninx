{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Import the niri module
  imports = [inputs.niri.nixosModules.niri];

  # Enable and configure
  programs.niri = {
    enable = true;
  };
}
