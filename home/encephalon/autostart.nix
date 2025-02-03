{
  config,
  pkgs,
  ...
}:
# packages to automatically start with GNOME
# see https://github.com/NixOS/nixpkgs/blob/master/pkgs/build-support/make-startupitem/default.nix
{
  home.packages = with pkgs; [
    (makeAutostartItem {
      name = "vesktop";
      package = vesktop;
    })
    (makeAutostartItem {
      name = "firefox";
      package = firefox;
    })
    (makeAutostartItem {
      name = "kitty";
      package = kitty;
    })
    (makeAutostartItem {
      name = "protonvpn-app";
      package = protonvpn-gui;
    })
    (makeAutostartItem {
      name = "heynote";
      package = heynote;
    })
  ];
}
