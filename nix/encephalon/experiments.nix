{
  config,
  pkgs,
  ...
}: {
  # Install ollama for running local LLMs
  services.ollama.enable = true;

  # Packages to play around with
  environment.systemPackages = with pkgs; [
    # My personally-updated warp terminal because it's fun
    warp-terminal
  ];
}
