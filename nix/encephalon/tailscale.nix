{
  config,
  lib,
  pkgs,
  ...
}: {
  ## OBSOLETE ##

  # Tailscale-specific networking configuration
  networking = {
    # Make MagicDNS work
    search = ["snow-vector.ts.net"];

    # NetworkManager tweaks
    networkmanager = {
      unmanaged = ["tailscale0"];
      insertNameservers = ["100.100.100.100"];
    };

    # Firewall settings
    firewall = {
      # Only need below if using regular "tailscale0"
      # Shouldn't be required if interface is "userspace-networking"
      trustedInterfaces = ["tailscale0"];

      # Maybe redundant with openFirewall setting in tailscale
      allowedUDPPorts = [config.services.tailscale.port];
    };
  };

  # Enable and configure Tailscale
  services.tailscale = {
    enable = true;

    # Networking
    port = 0; # autoselect port to use for tailscale, default is 41641
    openFirewall = true; # open selected port in firewall
    useRoutingFeatures = "client"; # "client" sets checkreversepath to "loose", "server" enables IP forwarding
    interfaceName = "tailscale0"; # userspace-networking or tailscale0

    # FIXME Security
    authKeyFile = config.age.secrets.encephalon.path;

    # Configuration
    extraUpFlags = [
      "--operator=sonar"
      "--ssh"
    ];
  };

  # Custom service to restart tailscaled and resolved after sleep
  # See if this is still necessary, definitely might be fixed now
  #systemd.services.tailscaled-restart = {
  #  enable = true;
  #  description = "Restart tailscaled correctly after sleep";
  #  wantedBy = ["post-resume.target"];
  #  serviceConfig = {
  #    Type = "oneshot";
  #    ExecStart = "systemctl restart tailscaled.service systemd-resolved.service";
  #  };
  #};
}
