{
  config,
  pkgs,
  ...
}: {
  networking.hostName = "encephalon";

  services.mullvad-vpn = {
    enable = true;
    enableExcludeWrapper = false;
    package = pkgs.mullvad-vpn;
  };
}
