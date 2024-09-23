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
      firefox.profileNames = ["sonar"];
      kitty.variant256Colors = true;
      nixvim.transparentBackground = {
        main = true;
        signColumn = true;
      };
    };
  };
}
