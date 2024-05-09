{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Enable and configure espanso
  services.espanso = {
    enable = true;
    package = pkgs.espanso-wayland;
  };
}
