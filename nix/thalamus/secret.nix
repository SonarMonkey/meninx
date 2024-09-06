{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Get the agenix module
  imports = [inputs.agenix.nixosModules.default];

  # Get the agenix tool
  environment.systemPackages = [inputs.agenix.packages.x86_64-linux.default];

  # FIXME Configure secrets
  age.secrets = {
    admin.file = ../../secrets/admin.age;
    waste.file = ../../secrets/waste.age;
  };
}
