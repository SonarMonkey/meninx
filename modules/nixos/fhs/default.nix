{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.environment.fhs;
  nix-alien-pkgs = import (
    builtins.fetchTarball "https://github.com/thiagokokada/nix-alien/tarball/master"
  ) {};
in {
  options.environment.fhs = {
    enable = mkEnableOption "Enable adding FHS and LD to run unpatched binaries";
    nix-ld = mkEnableOption "Enable the standard nix-ld environment";
    appimage = mkEnableOption "Register appimages to run correctly";
    alien = mkEnableOption "Install nix-alien to run unpatched binaries";
  };

  config = mkIf cfg.enable {
    programs.nix-ld.enable = cfg.nix-ld;
    environment.systemPackages = [
      (mkIf cfg.appimage pkgs.appimage-run)
      (mkIf cfg.alien nix-alien-pkgs.nix-alien)
    ];
    boot.binfmt.registrations.appimage = mkIf cfg.appimage {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
    };
  };
}
