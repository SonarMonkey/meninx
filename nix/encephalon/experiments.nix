{
  config,
  pkgs,
  ...
}: {
  # Install ollama for running local LLMs
  services.ollama.enable = true;
  services.nextjs-ollama-llm-ui.enable = true;

  # Stuff from charm.sh for scripts and experiments
  environment.systemPackages = with pkgs; [
    warp-terminal
    charm-freeze
    glow
    gum
  ];
}
