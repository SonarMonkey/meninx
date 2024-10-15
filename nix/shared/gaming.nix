{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Get the platform optimizations from nix-gaming
  imports = [inputs.nix-gaming.nixosModules.platformOptimizations];

  # Get gaming-related packages
  environment.systemPackages = with pkgs; [
    # General gaming utilities
    goverlay
    mangohud
    vkbasalt
    vulkan-tools

    # Games
    osu-lazer-bin
    prismlauncher
  ];

  programs = {
    # Configure steam itself
    steam = {
      # Enable steam with SteamOS optimizations
      enable = true;
      platformOptimizations.enable = true;

      # Add extra compatibility packages
      extraCompatPackages = [
        pkgs.proton-ge-bin
      ];

      # Configure firewall settings
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
  };
}
