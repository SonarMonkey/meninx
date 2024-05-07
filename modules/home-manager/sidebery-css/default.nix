{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  # TODO replace cfg.hash with more elegant solution
  cfg = config.programs.firefox.sidebery-css;
in {
  options.programs.firefox.sidebery-css = {
    enable = mkEnableOption "Enable CSS hacks for FireFox for a sidebery-only experience";
    version = mkOption {
      type = types.str;
      default = "master";
      description = "The rev/tag of firefox-csshacks to install";
    };
    hash = mkOption {
      type = types.str;
      description = "The sha-256 hash of the provided version";
    };
    profile = mkOption {
      type = types.str;
      description = "The firefox profile to install the CSS into";
    };
  };

  config = mkIf cfg.enable {
    programs.firefox.profiles."${cfg.profile}" = {
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.uidensity" = 0;
        "svg.context-properties.content.enabled" = true;
        "browser.theme.dark-private-windows" = false;
      };

      userChrome = ''
        @import url(window_control_placeholder_support.css);
        @import url(window_control_force_linux_system_style.css);
        @import url(hide_tabs_toolbar.css);
        @import url(urlbar_centered_text.css);
        @import url(autohide_sidebar.css);

        #sidebar-header {
          display: none;
        }

        #sidebar-box{
          --uc-sidebar-width: 34px;
          --uc-sidebar-hover-width: 230px;
          --uc-autohide-sidebar-delay: 600ms;
          --uc-autohide-transition-duration: 115ms;
          --uc-autohide-transition-type: linear;
          position: relative;
          min-width: var(--uc-sidebar-width) !important;
          width: var(--uc-sidebar-width) !important;
          max-width: var(--uc-sidebar-width) !important;
          z-index:1;
        }
      '';
    };

    home.file = {
      # Fix window controls
      ".mozilla/firefox/${cfg.profile}/chrome/window_control_placeholder_support.css".text =
        builtins.readFile
        (pkgs.fetchFromGitHub {
            owner = "MrOtherGuy";
            repo = "firefox-csshacks";
            rev = cfg.version;
            hash = cfg.hash;
          }
          + "/chrome/window_control_placeholder_support.css");

      # Fix window control theme
      ".mozilla/firefox/${cfg.profile}/chrome/window_control_force_linux_system_style.css".text =
        builtins.readFile
        (pkgs.fetchFromGitHub {
            owner = "MrOtherGuy";
            repo = "firefox-csshacks";
            rev = cfg.version;
            hash = cfg.hash;
          }
          + "/chrome/window_control_force_linux_system_style.css");

      # Hide the tab toolbar
      ".mozilla/firefox/${cfg.profile}/chrome/hide_tabs_toolbar.css".text =
        builtins.readFile
        (pkgs.fetchFromGitHub {
            owner = "MrOtherGuy";
            repo = "firefox-csshacks";
            rev = cfg.version;
            hash = cfg.hash;
          }
          + "/chrome/hide_tabs_toolbar.css");

      # Center the text in the url bar
      ".mozilla/firefox/${cfg.profile}/chrome/urlbar_centered_text.css".text =
        builtins.readFile
        (pkgs.fetchFromGitHub {
            owner = "MrOtherGuy";
            repo = "firefox-csshacks";
            rev = cfg.version;
            hash = cfg.hash;
          }
          + "/chrome/urlbar_centered_text.css");

      # Automatically collapse sidebery
      ".mozilla/firefox/${cfg.profile}/chrome/autohide_sidebar.css".text =
        builtins.readFile
        (pkgs.fetchFromGitHub {
            owner = "MrOtherGuy";
            repo = "firefox-csshacks";
            rev = cfg.version;
            hash = cfg.hash;
          }
          + "/chrome/autohide_sidebar.css");
    };
  };
}
