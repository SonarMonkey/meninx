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

  # General networking settings
  networking = {
    # Set hostname
    hostName = "encephalon";

    # Explicitly set DNS servers, may be ignored by resolvconf though
    # Shouldn't be an issue, switched to systemd-resolved as resolvconf
    nameservers = [
      # Local IPs
      "127.0.0.1"
      "::1"
    ];

    # NetworkManager configuration
    # TODO add NetworkManager profiles
    networkmanager = {
      # Pretty sure this is enable automatically with GNOME
      enable = true;

      # Make sure DNS servers are not overridden
      dns = "none";
    };

    # Make sure DNS servers are not overridden
    dhcpcd.extraConfig = "nohook resolv.conf";

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

    # Encrypted DNS
    dnscrypt-proxy2 = {
      # Basic settings
      enable = true;
      settings = {
        ipv6_servers = config.networking.enableIPv6;
        block_ipv6 = ! (config.networking.enableIPv6);

        # Server requirements
        require_dnssec = true;
        require_nolog = true;
        require_nofilter = false;

        # Quad9 resolvers
        sources.quad9-resolvers = {
          urls = [
            "https://quad9.net/dnscrypt/quad9-resolvers.md"
            "https://raw.githubusercontent.com/Quad9DNS/dnscrypt-settings/main/dnscrypt/quad9-resolvers.md"
          ];
          minisign_key = "RWQBphd2+f6eiAqBsvDZEBXBGHQBJfeG6G+wJPPKxCZMoEQYpmoysKUN";
          cache_file = "quad9-resolvers.md";
          refresh_delay = 72;
          prefix = "quad9-";
        };

        # Explicitly set Quad9 dnscrypt servers
        server_names = [
          # IPv4
          "dnscrypt-ip4-filter-pri"
          "dnscrypt-ip4-filter-alt"
          "dnscrypt-ip4-filter-alt2"

          # IPv6
          "dnscrypt-ip6-filter-pri"
          "dnscrypt-ip6-filter-alt"
          "dnscrypt-ip6-filter-alt2"
        ];
      };
    };
  };
}
