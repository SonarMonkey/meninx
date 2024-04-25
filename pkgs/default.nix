# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
{pkgs}: {
  # example = pkgs.callPackage ./example { };
  warp-terminal = pkgs.callPackage ./warp-terminal {};
  dnd-tools = pkgs.callPackage ./dnd-tools {};
  mullvad-vpn = pkgs.callPackage ./mullvad-vpn {};
}
