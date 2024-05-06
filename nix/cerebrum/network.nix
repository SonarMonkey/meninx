{
  config,
  lib,
  pkgs,
  ...
}: {
  # Set hostname
  networking.hostName = "cerebrum";

  # Networking-related system services
  services = {
    # System SSH daemon
    openssh.enable = true;

    # Mullvad
    mullvad-vpn = {
      enable = true;
      enableExcludeWrapper = true;
      package = pkgs.mullvad-vpn;
    };

    # TailScale service
    tailscale = {
      enable = true;
      authKeyFile = config.age.secrets.cerebrum.path;
      openFirewall = true;
      useRoutingFeatures = "client";
      interfaceName = "userspace-networking";
      extraUpFlags = [
        "--operator=sonar"
        "--ssh"
      ];
    };
  };
}
