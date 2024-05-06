{
  config,
  lib,
  pkgs,
  ...
}: {
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
    # Also detected by tailscale to create a rule to not manage tailscale
    useNetworkd = true;

    # Whether to enable dhcpcd for device configuration.
    # This is mainly to explicitly disable dhcpcd
    # (for example when using networkd).
    dhcpcd.enable = false;

    # Explicitly set DNS servers, may be ignored by resolvconf though
    # Shouldn't be an issue, switched to systemd-resolved as resolvconf
    nameservers = [
      # NextDNS
      "45.90.28.0#df9e75.dns.nextdns.io"
      "45.90.30.0#df9e75.dns.nextdns.io"
      "2a07:a8c0::#df9e75.dns.nextdns.io"
      "2a07:a8c1::#df9e75.dns.nextdns.io"

      # Quad9 w/ Malware Blocking & DNSSEC Validation
      "9.9.9.9#dns.quad9.net"
      "149.112.112.112#dns.quad9.net"
      "2620:fe::fe#dns.quad9.net"
      "2620:fe::9#dns.quad9.net"
    ];

    # NetworkManager configuration
    networkmanager = {
      # Pretty sure this is enable automatically with GNOME
      # Enabling explicitly just in case as in my previous config
      enable = true;

      # Might need since I'm using systemd-resolved
      dns = "systemd-resolved";
    };

    # Enable nftables instead of legacy iptables backend for firewall
    # Questionable, may interfere with docker and libvirtd, not sure
    nftables.enable = true;

    # Enable firewall
    firewall.enable = true;
  };

  # Networking services
  services = {
    # System SSH daemon
    openssh.enable = true;

    # Systemd-resolved configuration, not sure how to deal with this
    # Note that this conflicts with networking.resolvconf.enable = true;
    # See https://wiki.nixos.org/wiki/Systemd/resolved for more info
    resolved = {
      enable = true;

      # Explicitly set fallback DNS to primary nameservers
      # Maybe not necessary with `networking.nameservers` set
      fallbackDns = config.networking.nameservers;

      # Will encrypt all DNS lookups or fail
      # Should be supported on NextDNS and Quad9
      dnsovertls = "true";

      # Also enable DNSSEC which my servers should support
      dnssec = "true";
    };
  };
}
