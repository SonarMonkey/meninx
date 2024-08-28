{
  config,
  pkgs,
  ...
}: {
  # Set laptop hostname
  networking.hostName = "encephalon";

  # Enable firewall
  networking.firewall.enable = true;

  # Enable Mullvad VPN w/GUI
  services.mullvad-vpn = {
    enable = true;
    enableExcludeWrapper = false;
    package = pkgs.mullvad-vpn;
  };
}
