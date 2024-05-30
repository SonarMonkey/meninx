{
  config,
  pkgs,
  inputs,
  outputs,
  ...
}: {
  # Get the home manager module
  imports = [inputs.home-manager.nixosModules.home-manager];

  # Configure basic Home Manager settings
  home-manager = {
    backupFileExtension = "hm-backup";
    extraSpecialArgs = {inherit inputs outputs;};
    useGlobalPkgs = true;
    useUserPackages = true;
    users.sonar = import ../../home/encephalon;
  };
}
