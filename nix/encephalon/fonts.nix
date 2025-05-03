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
    # TODO nerd-fonts
    packages = with pkgs; [
      cantarell-fonts
      corefonts
      inter
      atkinson-hyperlegible
      maple-mono.NF
      noto-fonts-color-emoji
      cozette
      spleen
    ];
  };
}
