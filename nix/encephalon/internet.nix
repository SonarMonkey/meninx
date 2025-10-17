{
  config,
  pkgs,
  ...
}: {
  # Set laptop hostname
  networking.hostName = "encephalon";

  # Enable firewall
  networking.firewall.enable = true;

  # Enable Proton VPN w/GUI
  environment.systemPackages = with pkgs; [protonvpn-gui];
}
