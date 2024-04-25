{
  config,
  pkgs,
  inputs,
  ...
}:
# All global theme configurations
{
  # Get the Stylix module
  imports = [inputs.stylix.nixosModules.stylix];

  # Configure system-wide Stylix options
  stylix = {
    # Basic settings for wallpaper and theme
    image = ../../assets/wallpaper.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    polarity = "dark";

    # Explicitly enable GNOME+GDM theme
    targets.gnome.enable = true;

    # Cursor settings
    cursor = {
      package = pkgs.catppuccin-cursors.mochaLight;
      name = "Catppuccin-Mocha-Light-Cursors";
      size = 32;
    };

    # Font settings
    fonts = {
      sizes = {
        applications = 12;
        desktop = 12;
        popups = 12;
        terminal = 12;
      };
      serif = {
        package = pkgs.cantarell-fonts;
        name = "Cantarell";
      };
      sansSerif = {
        package = pkgs.cantarell-fonts;
        name = "Cantarell";
      };
      monospace = {
        package = pkgs.maple-mono-NF;
        name = "Maple Mono NF";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
