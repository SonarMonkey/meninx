{
  config,
  pkgs,
  ...
}: {
  # Printing and such
  services = {
    # Printing with CUPS
    printing = {
      enable = true;
      stateless = true;

      # FIXME various printer drivers
      #drivers = with pkgs; [
      #  gutenprint
      #  gutenprintBin
      #  hplip
      #  hplipWithPlugin
      #  postscript-lexmark
      #  samsung-unified-linux-driver
      #  splix
      #  brlaser
      #  brgenml1lpr
      #  brgenml1cupswrapper
      #  cnijfilter2
      #];
    };

    # Printer auto-discovery
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
