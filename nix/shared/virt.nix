{
  config,
  pkgs,
  inputs,
  outputs,
  ...
}: {
  # Enable libvirtd
  virtualisation.libvirtd.enable = true;

  # Necessary user groups for virtualisation
  users.users.sonar.extraGroups = ["libvirtd"];
}
