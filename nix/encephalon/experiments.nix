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

    # Logseq to fuck with again
    logseq
  ];

  nixpkgs.config = {
    permittedInsecurePackages = ["electron-28.3.3"];
  };
}
