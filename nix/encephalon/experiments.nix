{
  config,
  pkgs,
  ...
}: {
  # Install ollama for running local LLMs
  #services.ollama.enable = true;

  # Stuff for scripts and experiments
  environment.systemPackages = with pkgs; [
    # Game dev stuff
    aseprite

    # MUD client
    blightmud
    mudlet

    # PCB and CAD
    kicad
  ];
}
