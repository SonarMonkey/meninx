{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Get the nixvim module
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  # Configure nixvim
  programs.nixvim = {
    # Basic settings
    enable = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    withRuby = true;

    # Configuration options
    opts = {
      conceallevel = 0;
      linebreak = true;
    };

    # Clipboard configuration
    clipboard = {
      register = "unnamedplus";
      providers = {
        # Wayland provider
        wl-copy = {
          enable = true;
          package = pkgs.wl-clipboard;
        };

        # X11 provider
        xclip.enable = true;
        xsel.enable = true;
      };
    };

    # Plugins
    plugins = {
      # Indent guides
      indent-blankline.enable = true;

      # Visual leap
      leap.enable = true;

      # Completion
      cmp.enable = true;

      # AI-assistant via codeium
      codeium-vim.enable = true;

      # Language servers
      lsp = {
        enable = true;

        # Available servers
        servers = {
          # General
          bashls.enable = true;
          jsonls.enable = true;
          gopls.enable = true;

          # Nix
          nil-ls = {
            enable = true;
            settings.formatting.command = ["alejandra"];
          };
        };
      };

      # Improve LSP
      lspsaga.enable = true;

      # Improved LSP formatting
      lsp-format.enable = true;

      # Nix language support
      nix.enable = true;

      # Autopair
      nvim-autopairs.enable = true;

      # Picker
      telescope = {
        enable = true;
        extensions = {
          file-browser.enable = true;
          frecency.enable = true;
          media-files.enable = true;
          ui-select.enable = true;
          undo.enable = true;
        };
      };

      # Syntax highlighting
      treesitter = {
        enable = true;
        nixvimInjections = true;
        settings = {
          indent.enable = true;
        };
      };

      # Code context
      treesitter-context.enable = true;

      # Keymap helper
      which-key.enable = true;
    };
  };
}
