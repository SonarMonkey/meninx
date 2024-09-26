{
  config,
  pkgs,
  ...
}: {
  # Allow Home Manager to manage itself
  programs.home-manager.enable = true;

  # Basic Home Manager settings
  home = {
    stateVersion = "24.05";
    username = "sonar";
    homeDirectory = "/home/sonar";
    preferXdgDirectories = true;
  };

  # Nicely restart user services on update
  systemd.user.startServices = "sd-switch";
}
