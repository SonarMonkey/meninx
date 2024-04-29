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
  # Not sure if enabling for boot is good/necessary
  boot.initrd.systemd.network.enable = true;
  systemd.network.enable = true;

  # General networking settings
  networking = {
    # Set hostname
    hostName = "encephalon";

    # Settings originally from hardware-configuration.nix
    # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
    # (the default) this is the recommended approach. When using systemd-networkd it's
    # still possible to use this option, but it's recommended to use it in conjunction
    # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
    useDHCP = lib.mkDefault false;
    interfaces.enp0s31f6.useDHCP = lib.mkDefault true;
    interfaces.wlp2s0.useDHCP = lib.mkDefault true;
    interfaces.tailscale0.useDHCP = lib.mkOverride false;
    interfaces.wg0-mullvad.useDHCP = lib.mkOverride false;

    # Disables legacy scripted networking, see "useDHCP" documentation above
    # Also detected by tailscale to create a rule to not manage tailscale
    useNetworkd = true;

    # Whether to enable dhcpcd for device configuration.
    # This is mainly to explicitly disable dhcpcd
    # (for example when using networkd).
    dhcpcd.enable = false;

    # This is apparently what fixes at least MagicDNS
    # Entire resolv.conf may be overwritten by tailscale
    # Also conflicts with services.resolved.enable below
    # See https://tailscale.com/kb/1235/resolv-conf/
    #resolvconf.enable = true;

    # Explicitly set DNS servers, may be ignored by resolvconf though
    nameservers = [
      # Tailcale
      "100.100.100.100"

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

    # Explicitly set search path to resolve unqualified domains on my tailnet
    search = ["snow-vector.ts.net"];

    # NetworkManager configuration
    networkmanager = {
      # Pretty sure this is enable automatically with GNOME
      # Enabling explicitly just in case as in my previous config
      enable = true;

      # Might need since I'm using systemd-resolved
      dns = "systemd-resolved";

      # Explicitly avoid managing the tailscale interface
      # May be redundant with tailscale service module
      unmanaged = ["tailscale0"]; # FIXME switched to userspace-networking

      #insertNameservers = []; # ??? might help adding my dns servers idk
      #appendNameservers = []; # ??? might help adding my dns servers idk

      # Consider setting networking.networkmanager.ensureProfiles.profiles
      # unrelated to ts issues but would declaratively manage wifi connections
      # See https://github.com/janik-haag/nm2nix to automatically do this

      # Consider setting settings.main.rc-manager = "resolvconf" to make networkmanager use it,
      # see https://developer-old.gnome.org/NetworkManager/stable/NetworkManager.conf.html
    };

    # Enable nftable instead of legacy iptables backend for firewall
    # Questionable, may interfere with docker and libvirtd, not sure
    nftables.enable = true;

    # Firewall settings
    firewall = {
      enable = true;

      # Only need below if using regular "tailscale0"
      # Shouldn't be required if interface is "userspace-networking"
      trustedInterfaces = ["tailscale0"]; # FIXME switched to userspace-networking
      allowedUDPPorts = [config.services.tailscale.port]; # maybe redundant with openFirewall setting in tailscale
    };
  };

  # Networking services
  services = {
    # System SSH daemon
    openssh = {
      enable = true;

      # Might allow resolving loose tailnet names
      #settings.useDns = true;

      # Consider also setting to listen on 100.100.100.100
      #listenAdresses = [{}{}];

      # Consider setting to declaratively manage key creation
      #hostKeys = [{}{}];

      # Consider setting to declaratively manage known hosts
      #knownHosts = {};
    };

    # Mullvad
    mullvad-vpn = {
      enable = true;
      enableExcludeWrapper = true;
      package = pkgs.mullvad-vpn;
    };

    # TailScale system service configuration
    # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/services/networking/tailscale.nix
    tailscale = {
      enable = true;

      # Networking
      port = 0; # autoselect port to use for tailscale, default is 41641
      openFirewall = true; # open selected port in firewall
      useRoutingFeatures = "client"; # "client" sets checkreversepath to "loose", "server" enables IP forwarding
      interfaceName = "userspace-networking"; # or "tailscale0" (default)

      # Security
      #permitCertUid = ""; # to allow specified user getting TLS certs
      authKeyFile = config.age.secrets.${config.networking.hostName}.path;

      # Configuration
      extraUpFlags = [
        "--operator=sonar"
        "--ssh"
      ];
    };

    # Systemd-resolved configuration, not sure how to deal with this
    # FIXME conflicts with networking.resolvconf.enable = true;
    resolved = {
      enable = true;

      # Explicitly set fallback DNS to primary nameservers
      fallbackDns = config.networking.nameservers;

      # This is the default, but setting for my own sake
      domains = config.networking.search;

      # Will encrypt all DNS lookups or fail
      # Should be supported on NextDNS and Quad9
      dnsovertls = "true";
    };
  };

  # Custom service to restart tailscaled and resolved after sleep
  # TODO see if this is still necessary, might be fixed now
  systemd.services.tailscaled-restart = {
    enable = true;
    description = "Restart tailscaled correctly after sleep";
    wantedBy = ["post-resume.target"];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "systemctl restart tailscaled.service systemd-resolved.service";
    };
  };
}
