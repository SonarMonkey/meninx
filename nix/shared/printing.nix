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
      drivers = with pkgs; [
        gutenprint
        gutenprintBin
        canon-cups-ufr2
        #hplip
      ];
    };

    # Printer auto-discovery
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
