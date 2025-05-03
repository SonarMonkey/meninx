{
  config,
  pkgs,
  ...
}: {
  users = {
    # Make users immutable
    mutableUsers = false;

    # Define my default user account
    users.sonar = {
      isNormalUser = true;
      description = "Riley Smith";
      extraGroups = ["networkmanager" "wheel" "dialout" "libvirtd"];
      hashedPasswordFile = config.age.secrets.sonar.path;
    };
  };
}
