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

    # Extra plugins not in nixvim
    extraPlugins = [];

    # Clipboard configuration
    clipboard = {
      register = "unnamedplus";
      providers = {
        # Wayland provider
        wl-clipboard = {
          enable = true;
          package = pkgs.wl-clipboard;
        };

        # X11 provider
        xclip.enable = true;
        xsel.enable = true;
      };
    };

    # Theme configuration
    colorschemes.cyberdream = {
      enable = true;
      settings = {
        italic_comments = true;
        transparent = true;
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

      # Language servers
      lsp = {
        enable = true;

        # Available servers
        servers = {
          # General
          bashls.enable = true;
          jsonls.enable = true;
          ltex.enable = true;
          marksman.enable = true;

          # Nix
          nil_ls = {
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
        folding = true;
        indent = true;
      };

      # Code context
      treesitter-context.enable = true;

      # Keymap helper
      which-key.enable = true;

      # Obsidian vault
      obsidian = {
        # Enable
        enable = true;

        # Settings
        settings = {
          # Vault location
          dir = "/home/sonar/Notes";
          workspaces.Notes = {
            names = "Notes";
            path = "/home/sonar/Notes";
          };

          # Subdirectory config
          notes_subdir = "pages";
          new_notes_location = "notes_subdir";
          attachments.img_folder = "assets";
          daily_notes.folder = "journals";
          templates.subdir = "templates";

          # Preferred picker
          picker.name = "telescope.nvim";
        };
      };
    };
  };
}
