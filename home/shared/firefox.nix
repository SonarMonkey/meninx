{
  config,
  pkgs,
  inputs,
  outputs,
  ...
}: {
  # TODO Import my custom CSS module
  #imports = [outputs.homeManagerModules.sidebery-css];

  # Enable and configure FireFox
  programs.firefox = {
    enable = true;

    # Policy settings
    policies = {
      # Basic settings
      HardwareAcceleration = true;
      DefaultDownloadDirectory = "\${home}/Downloads";

      # Disable annoying stuff
      AppAutoUpdate = false;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DisplayBookmarksToolbar = "always";
      OfferToSaveLogins = false;

      # Hard-disable Firefox's DoH
      DNSOverHTTPS = {
        Enabled = false;
        Locked = true;
      };

      # Search configuration
      SearchSuggestEnabled = true;
      FirefoxSuggest = {
        SponsoredSuggestions = false;
        ImproveSuggest = false;
      };
    };

    # Configure my user profile
    profiles."sonar" = {
      isDefault = true;

      # Install extensions
      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        bitwarden
        clearurls
        darkreader
        duckduckgo-privacy-essentials
        foxytab
        ghostery
        improved-tube
        privacy-badger
        sidebery
        ublock-origin
        raindropio
        unpaywall
      ];

      # Configure search settings
      search = {
        default = "DuckDuckGo";
        force = true;
        order = ["DuckDuckGo" "Nix Packages" "NixOS Wiki" "Google"];

        # Add Nix and Wiki searching
        engines = {
          # Nix package search
          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@np"];
          };

          # Nix wiki search
          "NixOS Wiki" = {
            urls = [
              {
                template = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@nw"];
          };

          # Disable garbage
          "Bing".metaData.hidden = true;
          "Amazon.com".metaData.hidden = true;
          "eBay".metaData.hidden = true;
        };
      };

      # Firefox settings
      settings = {
        # General settings
        "browser.contentblocking.category" = "standard";
        "browser.gnome-search-provider.enabled" = true;
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.search.suggest.enabled" = true;
        "browser.startup.page" = 3;
        "browser.download.useDownloadDir" = false;
        "dom.security.https_only_mode" = true;
        "experiments.activeExperiment" = false;
        "experiments.enabled" = false;
        "experiments.supported" = false;
        "extensions.pocket.enabled" = false;
        "gfx.webrender.all" = true;
        "network.allow-experiments" = false;
        "privacy.donottrackheader.enabled" = true;
        "privacy.donottrackheader.value" = 1;
        "signon.rememberSignons" = false;
        "widget.use-xdg-desktop-portal.file-picker" = 1;

        # Theme settings
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.uidensity" = 0;
        "svg.context-properties.content.enabled" = true;
        "browser.theme.dark-private-windows" = false;
        "widget.gtk.rounded-bottom-corners.enabled" = true;
        "layers.acceleration.force-enabled" = true;
      };

      # Set up userChrome to import my css tweaks
      userChrome = ''
        @import url(hide_tabs_toolbar_v2.css);
        @import url(urlbar_centered_text.css);
        @import url(autohide_sidebar.css);

        #sidebar-header {
          display: none;
        }

        #sidebar-box{
          --uc-sidebar-width: 34px;
          --uc-sidebar-hover-width: 230px;
        }
      '';
    };
  };

  # Add the actual CSS tweaks
  home.file = let
    currHash = "sha256-ZThxJ6/dH6dYieOLEwHYGivEG0gESoWUKoYu2FvEhgU=";
  in {
    # Hide the tab toolbar
    ".mozilla/firefox/sonar/chrome/hide_tabs_toolbar_v2.css".text =
      builtins.readFile
      (pkgs.fetchFromGitHub {
          owner = "MrOtherGuy";
          repo = "firefox-csshacks";
          rev = "master";
          hash = currHash;
        }
        + "/chrome/hide_tabs_toolbar.css");

    # Center the text in the url bar
    ".mozilla/firefox/sonar/chrome/urlbar_centered_text.css".text =
      builtins.readFile
      (pkgs.fetchFromGitHub {
          owner = "MrOtherGuy";
          repo = "firefox-csshacks";
          rev = "master";
          hash = currHash;
        }
        + "/chrome/urlbar_centered_text.css");

    # Automatically collapse sidebery
    ".mozilla/firefox/sonar/chrome/autohide_sidebar.css".text =
      builtins.readFile
      (pkgs.fetchFromGitHub {
          owner = "MrOtherGuy";
          repo = "firefox-csshacks";
          rev = "master";
          hash = currHash;
        }
        + "/chrome/autohide_sidebar.css");
  };
}
