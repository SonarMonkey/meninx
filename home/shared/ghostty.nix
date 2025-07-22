{
  config,
  pkgs,
  ...
}: {
  # Ghostty
  programs.ghostty = {
    enable = true;
    installBatSyntax = true;
    installVimSyntax = true;

    # General settings
    settings = {
      # Appearance
      font-family = "Maple Mono NF";
      theme = "Adwaita Dark";
      gtk-titlebar-hide-when-maximized = true;
      gtk-adwaita = true;

      # Startup
      command = "zellij -l \"welcome\"";
      maximize = true;

      # Mouse settings
      cursor-click-to-move = true;
      mouse-hide-while-typing = true;
      focus-follows-mouse = true;

      # Clipboard usage
      clipboard-read = "allow";
      clipboard-write = "allow";
      clipboard-trim-trailing-spaces = true;
      copy-on-select = "clipboard";
    };
  };

  # Zellij layout until https://github.com/ghostty-org/ghostty/discussions/2480
  programs.zellij = {
    enable = true;

    # Only enable fish integration
    enableBashIntegration = false;
    enableZshIntegration = false;
    enableFishIntegration = true;

    # Resume automatically
    attachExistingSession = true;
    exitShellOnExit = true;

    # General settings
    settings = {
      # Basic stuff
      default_shell = "fish";
      copy_command = "wl-copy";

      # Start and resume nicely
      pane_viewport_serialization = true;
      show_startup_tips = false;

      # Improve UI a bit
      ui.pane_frames = {
        rounded_corners = true;
        hide_session_name = true;
      };
    };

    # Configure available layouts
    layouts = {
      # Default layout
      default = ''
        // Default layout
        layout {
            // Re-usable base layout for tabs
            default_tab_template {
                pane size=1 borderless=true {
                    plugin location="zellij:tab-bar"
                }
                children
                pane size=2 borderless=true {
                    plugin location="zellij:status-bar"
                }
            }

            // Default startup layout
            tab {
                pane split_direction="vertical" {
                    pane
                    pane split_direction="horizontal" {
                        pane cwd="~/Nix"
                        pane command="btm" close_on_exit=true
                    }
                }
            }
        }
      '';
    };
  };
}
