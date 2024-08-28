{
  config,
  pkgs,
  ...
}: {
  # Install ollama for running local LLMs
  #services.ollama.enable = true;

  # Nice rules for performance
  #ananicy = {
  #  enable = true;
  #  package = pkgs.ananicy-cpp;
  #  rulesProvider = pkgs.ananicy-cpp;
  #};

  # Stuff from charm.sh for scripts and experiments
  environment.systemPackages = with pkgs; [
    # Game dev stuff
    aseprite
    godot_4

    # MUD client
    blightmud
    mudlet

    # PCB and CAD
    kicad
  ];
}
