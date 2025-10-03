{
  config,
  pkgs,
  inputs,
  outputs,
  ...
}: {
  # Import zen flake module
  imports = [
    inputs.zen-browser.homeModules.twilight
  ];

  # TODO maybe add xdg file associations??
  # see github.com/luisnquin/nixos-config/blob/main/home/modules/programs/browser/zen.nix

  # TODO Install sites as PWA's
  # also see programs.firefoxpwa.* for more
  # seems very cool and fully declarative
  #programs.zen-browser.nativeMessagingHosts = [pkgs.firefoxpwa];

  # Enable and configure Zen browser
  programs.zen-browser = {
    enable = true;

    # Policy settings
    policies = let
      mkLockedAttrs = builtins.mapAttrs (_: value: {
        Value = value;
        Status = "locked";
      });
    in {
      # Main policies settings
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      CaptivePortal = true; # blessed coffee shop wifi
      DefaultDownloadDirectory = "\${home}/Downloads";
      DisableAppUpdate = true; # already off by default in hmmodule?
      DisableFeedbackCommands = true; # think this is on by default idk
      DisableFirefoxAccounts = true; # maybe should leave it? idk
      DisableFirefoxStudies = true; # don't use my browser for experiments
      DisablePocket = true; # cringe that i even have to do this
      DisableTelemetry = true; # thoroughly disabled by zen anyway
      DisplayBookmarksToolbar = "never"; # default setting in zen
      DontCheckDefaultBrowser = true; # browsers should not do this
      HardwareAcceleration = true; # TODO make sure MOZ envvars getting set
      HttpsOnlyMode = "enabled"; # TODO make sure this doesn't need more config
      NoDefaultBookmarks = true; # also cringe that i have to do this
      OfferToSaveLogins = false; # i have a password manager for a reason
      PromptForDownloadLocation = true;
      SearchSuggestEnabled = true; # TODO i am not sure if this is what i want
      SkipTermsOfUse = true; # default in zen i think? still, leave me alone

      # Slightly more aggressive tracking protection
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
        EmailTracking = true;
        SuspectedFingerprinting = true;
      };

      # Probably redundant with default zen settings
      FirefoxHome = {
        Search = true;
        TopSites = false;
        SponsoredTopSites = false;
        Highlights = false;
        Pocket = false;
        Stories = false;
        SponsoredPocket = false;
        SponsoredStories = false;
        Snippets = false;
        Locked = true;
      };

      # Turn all this nonsense off
      FirefoxSuggest = {
        WebSuggestions = false;
        SponsoredSuggestions = false;
        ImproveSuggest = false;
        Locked = true;
      };

      # Disable DoH and lock
      # TODO double-check vpn stuff
      DNSOverHTTPS = {
        Enabled = false;
        Locked = true;
      };

      # Other basic preferences, some probably redundant
      Preferences = mkLockedAttrs {
        "browser.aboutConfig.showWarning" = false;
        "browser.contentblocking.category" = "standard";
        "browser.ctrlTab.sortByRecentlyUsed" = true;
        "browser.tabs.hoverPreview.enabled" = true;
        "browser.tabs.warnOnClose" = false;
        "dom.battery.enabled" = false;
        "experiments.enabled" = false;
        "experiments.supported" = false;
        "network.allow-experiments" = false;
        "network.http.http3.enabled" = true;
        "privacy.donottrackheader.enabled" = true;
        "privacy.donottrackheader.value" = 1;
        "privacy.firstparty.isolate" = true;
        "privacy.resistFingerprinting" = true;
        "signon.rememberSignons" = false;

        # Questionable settings
        "layers.acceleration.force-enabled" = true; # enabled in ./firefox.nix but idk
        "extensions.autoDisableScopes" = 0; # probably security risk but auto-enables extensions
        "network.cookie.cookieBehavior" = 5; # not entirely sure what behavior "5" actually is
        "gfx.webrender.all" = true; # maybe rendundant with accel setting in policy? not sure
      };
    };

    # Default user profile config
    profiles.default = {
      # Zen-specific settings
      settings = {
        "zen.workspaces.continue-where-left-off" = true;
        "zen.workspaces.force-container-workspace" = true;
        "zen.view.compact.hide-tabbar" = true;
        "zen.view.compact.hide-toolbar" = true;
        "zen.view.show-newtab-button-top" = false;

        # TODO maybe these too?
        #"zen.view.experimental-no-window-controls" = true;
        #"zen.view.compact.animate-sidebar" = false;
        #"zen.pinned-tab-manager.restore-pinned-tabs-to-pinned-url" = true;

        # On by default, for future reference <3
        #"browser.newtabpage.activity-stream.feeds.topsites" = false;
        #"browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        #"browser.newtabpage.activity-stream.newtabWallpapers.enabled" = true;
        #"browser.newtabpage.activity-stream.newtabWallpapers.v2.enabled" = true;
        #"browser.newtabpage.activity-stream.system.showWeather" = false;
        #"browser.topsites.contile.enabled" = false;
        #"browser.translations.newSettingsUI.enable" = true;
        #"media.videocontrols.picture-in-picture.video-toggle.enabled" = true; # not sure what this is
        #"media.videocontrols.picture-in-picture.enable-when-switching-tabs.enabled" = false; # may want true?
        #"browser.formfill.enable" = false; # may conflict with my policies
      };

      # TODO Basic user bookmarks
      #bookmarks = {};

      # Extensions and settings
      extensions = {
        # TODO Packages to use, shout-out rycee
        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
        ];

        # Force override, to use settings below
        #force = true;
        # TODO Individual extension settings
        #settings = {};
      };

      # Container setup
      containersForce = true;
      containers = {
        personal = {
          color = "pink";
          icon = "chill";
          id = 1;
        };
        work = {
          color = "yellow";
          icon = "briefcase";
          id = 2;
        };
        money = {
          color = "green";
          icon = "dollar";
          id = 3;
        };
        private = {
          color = "orange";
          icon = "fence";
          id = 4;
        };
      };

      # Spaces setup
      # TODO configure colors and icons
      spacesForce = true;
      spaces = {
        "Home" = {
          id = "f7697cda-1207-4a8e-8b78-79ed4133d84a";
          icon = "";
          position = 1000;
        };
        "Computer" = {
          id = "a8623239-4496-4153-83f0-1946bd7268af";
          icon = "";
          position = 2000;
        };
        "Work" = {
          id = "30fef135-77c3-4683-9ead-d84dc643381c";
          icon = "";
          position = 3000;
          container = 2;
        };
        "Shopping" = {
          id = "50332838-c31b-44d7-8737-fed6e85978f6";
          icon = "";
          position = 4000;
          container = 3;
        };
        "Suspicious" = {
          id = "7d0e8272-9645-44f1-a06f-2a2e431345ae";
          icon = "";
          position = 5000;
          container = 4;
        };
        "Personal" = {
          id = "d1bdcffc-3849-40f0-bdeb-c3b392ecae6e";
          icon = "";
          position = 6000;
          container = 1;
        };
      };

      # Search engine(s)
      search = {
        force = true;
        default = "ddg";
        order = ["ddg" "tabs" "nw" "np" "no"];

        # TODO hide or delete default other stuff

        engines = {
          # Disable nonsense
          "google".metaData.hidden = true;
          "bing".metaData.hidden = true;

          # Nix package search (unstable)
          nix-packages = {
            name = "Nix Packages";
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "channel";
                    value = "unstable";
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

          # NixOS option search (unstable)
          nix-options = {
            name = "Nix Options";
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "channel";
                    value = "unstable";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@no"];
          };

          # Official NixOS wiki search
          nixos-wiki = {
            name = "NixOS Wiki";
            urls = [{template = "https://wiki.nixos.org/w/index.php?search={searchTerms}";}];
            iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
            definedAliases = ["@nw"];
          };
        };
      };
    };
  };
}
