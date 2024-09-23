{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Import stylix module
  imports = [inputs.stylix.nixosModules.stylix];

  # Basic system-wide stylix settings
  stylix = {
    enable = true;

    # Wallpaper and colorscheme
    image = ../../assets/tokyonight.png;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";

    # Cursor
    cursor = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };

    # Fonts
    fonts = {
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
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
