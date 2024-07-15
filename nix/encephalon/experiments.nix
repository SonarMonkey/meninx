{
  config,
  pkgs,
  ...
}: {
  # Install ollama for running local LLMs
  services.ollama.enable = true;

  # Stuff from charm.sh for scripts and experiments
  environment.systemPackages = with pkgs; [
    # Charm utils
    gum

    # Game dev stuff
    aseprite
    godot_4
  ];
}
