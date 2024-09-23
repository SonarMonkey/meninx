{
  config,
  pkgs,
  ...
}: {
  # Home-manager-specific stylix configs
  stylix = {
    enable = true;

    # Configure individual targets
    targets = {
      firefox.profilenames = [];
      gtk.extraCss = '''';
      kitty.variant256Colors = true;
      nixvim = {};
    };
  };
}
