{
  config,
  pkgs,
  lib,
  ...
}: {
  # Install fonts
  fonts = {
    # Basic settings and packages
    enableDefaultPackages = true;
    fontDir.enable = true;

    # Fontconfig
    fontconfig = {
      enable = true;
      allowBitmaps = true;
    };

    # Personal fonts to install
    packages = with pkgs; [
      corefonts
      inter
      atkinson-hyperlegible
      maple-mono-NF
      nerdfonts
      noto-fonts-color-emoji
      cozette
      spleen
    ];
  };
}
