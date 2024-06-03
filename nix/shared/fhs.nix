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
  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
  };

  programs.appimage = {
    enable = true;
    binfmt = true;
  };
}
