{
  config,
  pkgs,
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

      # Set system-wide default fonts
      defaultFonts = {
        serif = ["Cantarell"];
        sansSerif = ["Cantarell"];
        monospace = ["Maple Mono NF"];
        emoji = ["Noto Color Emoji"];
      };
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
    ];
  };
}
