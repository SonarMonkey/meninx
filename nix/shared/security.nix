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
    sonar.file = ../../secrets/sonar.age;
    cerebrum.file = ../../secrets/cerebrum.age;
    encephalon.file = ../../secrets/encephalon.age;
    mullvad.file = ../../secrets/mullvad.age;
  };

  # Enable OpenSSH
  services.openssh.enable = true;

  # TODO Consider setting to declaratively manage known hosts
  #knownHosts = {};

  # System GNUPG agent with SSH support
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
