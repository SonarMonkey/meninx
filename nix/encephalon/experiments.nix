{
  config,
  pkgs,
  ...
}: {
  # Install ollama for running local LLMs
  services.ollama.enable = true;

  # Stuff from charm.sh for scripts and experiments
  environment.systemPackages = with pkgs; [
    # Programs to play with
    warp-terminal

    # Charm utils
    charm-freeze
    glow
    gum

    # Dwarf fortress "full" pack
    dwarf-fortress-packages.dwarf-fortress-full
  ];
}
