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

  # Zellij for layout until https://github.com/ghostty-org/ghostty/discussions/2480
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

      # Layout (use my custom below)
      default_layout = "sonar";

      # UI tweaks
      ui.pane_frames = {
        rounded_corners = true;
        hide_session_name = true;
      };

      # Start and resume nicely
      pane_viewport_serialization = true;
      show_startup_tips = false;
    };

    # Configure available layouts
    layouts = {
      # Default layout
      sonar = ''
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
