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

    # New editor
    zed-editor

    # MUD client
    blightmud
    mudlet

    # PCB and CAD
    kicad

    # Modular synth stuff
    cardinal
    bespokesynth
    sunvox
    orca
  ];
}
