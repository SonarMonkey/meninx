{
  config,
  lib,
  pkgs,
  ...
}: {
  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault false;
  networking.interfaces.enp0s31f6.useDHCP = lib.mkDefault true;
  networking.interfaces.wlp2s0.useDHCP = lib.mkDefault true;

  # When systemd-networkd is enabled, but a different service
  # is responsible for managing the system’s internet connection
  # (for example, NetworkManager or connman are used to manage WiFi connections),
  # this service is unnecessary and can be disabled.
  boot.initrd.systemd.network.wait-online.enable = false;
  systemd.network.wait-online.enable = false;

  # Enable systemd-networkd
  systemd.network.enable = true;

  # General networking settings
  networking = {
    # Set hostname
    hostName = "encephalon";

    # Disables legacy scripted networking, see "useDHCP" documentation above
    useNetworkd = true;

    # Whether to enable dhcpcd for device configuration.
    # This is mainly to explicitly disable dhcpcd
    # (for example when using networkd).
    dhcpcd.enable = false;

    # Explicitly set DNS servers, may be ignored by resolvconf though
    # Shouldn't be an issue, switched to systemd-resolved as resolvconf
    nameservers = [
      # Quad9 w/ Malware Blocking & DNSSEC Validation
      "9.9.9.9#dns.quad9.net"
      "149.112.112.112#dns.quad9.net"
      "2620:fe::fe#dns.quad9.net"
      "2620:fe::9#dns.quad9.net"
    ];

    # NetworkManager configuration
    # TODO add NetworkManager profiles
    networkmanager = {
      # Pretty sure this is enable automatically with GNOME
      # Enabling explicitly just in case as in my previous config
      enable = true;

      # Might need since I'm using systemd-resolved
      dns = "systemd-resolved";
    };

    # Enable firewall
    firewall.enable = true;
  };

  # Networking services
  services = {
    # Mullvad
    mullvad-vpn = {
      enable = true;
      enableExcludeWrapper = false;
      package = pkgs.mullvad-vpn;
    };

    # Systemd-resolved configuration, not sure how to deal with this
    # Note that this conflicts with networking.resolvconf.enable = true;
    # See https://wiki.nixos.org/wiki/Systemd/resolved for more info
    resolved = {
      enable = true;

      # Will encrypt all DNS lookups or fail
      # Should be supported on Quad9
      dnsovertls = "true";

      # Also enable DNSSEC which my servers should support
      dnssec = "true";
    };
  };
}
