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

  # Configure secrets
  age.secrets = {
    sonar.file = ../../secrets/sonar.age;
    encephalon.file = ../../secrets/encephalon.age;
  };

  # Enable OpenSSH
  services.openssh.enable = true;

  # System GNUPG agent with SSH support
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
