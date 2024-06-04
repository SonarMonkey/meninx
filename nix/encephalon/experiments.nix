{
  config,
  pkgs,
  ...
}: {
  # Install ollama for running local LLMs
  services.ollama.enable = true;

  # Install and configure private-gpt for local AI
  services.private-gpt = {
    enable = true;

    # Default ollama configuration from private-gpt docs
    # https://github.com/zylon-ai/private-gpt/blob/main/settings-ollama.yaml
    # Merged with the default config that comes with this module
    settings = {
      data = {
        local_data_folder = "/var/lib/private-gpt";
      };
      llm = {
        mode = "ollama";
        prompt_style = "mistral";
        max_new_tokens = 512;
        context_window = 3900;
        temperature = 0.1;
        tokenizer = "";
      };
      embedding = {
        mode = "ollama";
      };
      ollama = {
        llm_model = "mistral";
        embedding_model = "nomic-embed-text";
        api_base = "http://localhost:11434";
        embedding_api_base = "http://localhost:11434";
        keep_alive = "5m";
        tfs_z = 1;
        top_k = 40;
        top_p = 0.9;
        repeat_last_n = 64;
        repeat_penalty = 1.2;
        request_timeout = 120;
      };
      vectorstore = {
        database = "qdrant";
      };
      qdrant = {
        path = "/var/lib/private-gpt/vectorstore/qdrant";
      };
    };
  };

  # Stuff from charm.sh for scripts and experiments
  environment.systemPackages = with pkgs; [
    warp-terminal
    jan
    charm-freeze
    glow
    gum
    melt
    mods
    skate
  ];
}
