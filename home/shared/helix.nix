{
  config,
  pkgs,
  ...
}: {
  # Configure helix
  programs.helix = {
    enable = true;

    # Extra packages for syntax highlighting and linting
    extraPackages = with pkgs; [
      clang-tools
      clojure-lsp
      gopls
      markdown-oxide
      marksman
      nil
      nodePackages.bash-language-server
      nodePackages.vscode-css-languageserver-bin
      nodePackages.vscode-html-languageserver-bin
      nodePackages.vscode-json-languageserver
      texlab
      yaml-language-server
    ];

    # Language configuration options
    languages = {
      language = [
        # Markdown
        {
          name = "markdown";
          language-servers = ["markdown-oxide" "marksman"];
        }

        # Nix lang
        {
          name = "nix";
          auto-format = true;
          language-servers = ["nil"];
          formatter.command = "${pkgs.alejandra}/bin/alejandra";
        }
      ];
    };

    # Other settings and configuration options
    settings = {
      # Theme
      theme = "adwaita-dark";

      # Editor settings
      editor = {
        line-number = "relative";
        cursorline = true;
        cursorcolumn = false;
        bufferline = "multiple";
        color-modes = true;
        popup-border = "all";
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
        file-picker.hidden = false;
        indent-guides.render = true;
        soft-wrap = {
          enable = true;
          max-wrap = 25;
          wrap-indicator = "";
        };
      };
    };
  };
}
