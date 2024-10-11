{
  config,
  pkgs,
  ...
}: {
  # Install ollama for running local LLMs
  services.ollama.enable = true;

  # Stuff for scripts and experiments
  environment.systemPackages = with pkgs; [
    alpaca
  ];
}
