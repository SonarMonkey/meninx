# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
{pkgs}: {
  #mullvad-vpn = pkgs.callPackage ./mullvad-vpn {};
  #mullvad = pkgs.callPackage ./mullvad {};
  #zed-editor = pkgs.callPackage ./zed-editor {};
  #codieum = pkgs.callPackage ./codeium {};
  #cozette = pkgs.callPackage ./cozette {};
  #twos = pkgs.callPackage ./twos {};
  heynote = pkgs.callPackage ./heynote {};
  sunvox = pkgs.callPackage ./sunvox {};
}
