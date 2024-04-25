{
  config,
  pkgs,
  ...
}: {
  # Enable SDDM and set default session
  services.displayManager = {
    sddm.enable = true;
    defaultSession = "plasmax11";
  };

  # Enable Plasma 6 desktop and disable qt5
  services.desktopManager.plasma6 = {
    enable = true;
    enableQt5Integration = false;
  };

  # Configure QT appearance
  qt = {
    enable = true;
    style = "breeze";
  };

  # Enable KDE Connect
  programs.kdeconnect.enable = true;

  # Enable dconf for gtk packages
  programs.dconf.enable = true;

  # Get KDE-specific packages
  environment.systemPackages = with pkgs; [
    kdePackages.yakuake
    kdePackages.partitionmanager
    kdePackages.okular
    kdePackages.kdenlive
    kdePackages.kalk
    kdePackages.filelight
    kdePackages.ark
  ];
}
