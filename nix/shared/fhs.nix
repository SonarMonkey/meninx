{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Install nix-alien
  environment.systemPackages = [
    inputs.nix-alien.packages.x86_64-linux.nix-alien
    pkgs.appimage-run
  ];

  # Enable nix-ld
  programs.nix-ld.enable = true;

  # Register appimages to run correctly
  boot.binfmt.registrations.appimage = {
    wrapInterpreterInShell = false;
    interpreter = "${pkgs.appimage-run}/bin/appimage-run";
    recognitionType = "magic";
    offset = 0;
    mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
    magicOrExtension = ''\x7fELF....AI\x02'';
  };
}
