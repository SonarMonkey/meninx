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
      name = "com.mitchellh.ghostty";
      package = ghostty;
    })
    (makeAutostartItem {
      name = "heynote";
      package = heynote;
    })
    (makeAutostartItem {
      name = "proton.vpn.app.gtk";
      package = protonvpn-gui;
    })
  ];
}
