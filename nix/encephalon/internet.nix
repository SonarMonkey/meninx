{
  config,
  lib,
  pkgs,
  ...
}: {
  # TODO add networkmanager profiles
  networking = {
    # Set hostname
    hostName = "encephalon";

    # Static nameservers
    nameservers = [
      # Local
      "127.0.0.1"
      "::1"

      # Quad9
      "9.9.9.9#dns.quad9.net"
      "149.112.112.112#dns.quad9.net"
      "2620:fe::fe#dns.quad9.net"
      "2620:fe::9#dns.quad9.net"
    ];

    # Make sure DNS is not overridden
    dhcpcd.enable = false;
    networkmanager.dns = "none";

    # Enable default firewall
    firewall.enable = true;
  };

  # Networking services
  services = {
    # Encrypted DNS
    dnscrypt-proxy2 = {
      enable = true;

      # Configuration
      settings = {
        # FIXME Server requirements
        require_dnssec = true;
        require_nolog = true;
        require_nofilter = true;

        # FIXME Specify quad9 server
        server_names = ["quad9"];

        # FIXME Quad9 configuration
        # Is this all that's needed?
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
      };
    };

    # Mullvad
    mullvad-vpn = {
      enable = true;
      enableExcludeWrapper = true;
      package = pkgs.mullvad-vpn;
    };

    nextdns = {
      enable = true;
      arguments = [
        "-profile"
        "df9e75"
      ];
    };
  };
}
