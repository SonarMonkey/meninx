{
  config,
  pkgs,
  ...
}: {
  users = {
    # Make users immutable
    mutableUsers = false;

    # Define my defauly user account
    users.sonar = {
      isNormalUser = true;
      description = "Riley Smith";
      extraGroups = ["networkmanager" "wheel" "dialout"];
      hashedPasswordFile = config.age.secrets.sonar.path;
    };
  };
}
