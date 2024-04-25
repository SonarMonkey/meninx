{
  config,
  lib,
  pkgs,
  ...
}: {
  # TODO make sure I don't need all that systemd network shit
  networking.hostName = "encephalon";
}
