{
  config,
  pkgs,
  lib,
  ...
}:
with lib.hm.gvariant; {
  # GNOME extensions
  programs.gnome-shell = {
    enable = true;
    extensions = [
      # Built-in extensions
      {
        id = "user-theme@gnome-shell-extensions.gcampax.github.com";
        package = pkgs.gnomeExtensions.user-themes;
      }
      {
        id = "windowsNavigator@gnome-shell-extensions.gcampax.github.com";
        package = pkgs.gnomeExtensions.windownavigator;
      }

      # User-added extensions
      {
        id = "appindicatorsupport@rgcjonas.gmail.com";
        package = pkgs.gnomeExtensions.appindicator;
      }
      {
        id = "AlphabeticalAppGrid@stuarthayhurst";
        package = pkgs.gnomeExtensions.alphabetical-app-grid;
      }
      {
        id = "app-hider@lynith.dev";
        package = pkgs.gnomeExtensions.app-hider;
      }
      {
        id = "blur-my-shell@aunetx";
        package = pkgs.gnomeExtensions.blur-my-shell;
      }
      {
        id = "caffeine@patapon.info";
        package = pkgs.gnomeExtensions.caffeine;
      }
      {
        id = "happy-appy-hotkey@jqno.nl";
        package = pkgs.gnomeExtensions.happy-appy-hotkey;
      }
      {
        id = "thinkpad-battery-threshold@marcosdalvarez.org";
        package = pkgs.gnomeExtensions.thinkpad-battery-threshold;
      }
    ];
  };

  dconf.settings = {
    "org/gnome/shell" = {
      # Make sure extensions are enabled
      disable-user-extensions = false;

      # Enable extensions
      enabled-extensions = [
        # Built-in extensions
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "windowsNavigator@gnome-shell-extensions.gcampax.github.com"
        "drive-menu@gnome-shell-extensions.gcampax.github.com"

        # User-added extensions
        "AlphabeticalAppGrid@stuarthayhurst"
        "app-hider@lynith.dev"
        "blur-my-shell@aunetx"
        "caffeine@patapon.info"
        "happy-appy-hotkey@jqno.nl"
        "thinkpad-battery-threshold@marcosdalvarez.org"
      ];
    };

    # Apps to hide from appgrid
    "org/gnome/shell/extensions/app-hider" = {
      hidden-apps = [
        "bottom.desktop"
        "cups.desktop"
        "Helix.desktop"
        "nvim.desktop"
        "org.gnome.Tour.desktop"
        "Steam Linux Runtime 3.0 (sniper).desktop"
        "xterm.desktop"
        "yazi.desktop"
        "yelp.desktop"
        "lvim.desktop"
        "wordgrinder.desktop"
      ];
    };

    # Appindicator config
    "org/gnome/shell/extensions/appindicator" = {
      tray-pos = "left";
      icon-saturation = 1.0;
      icon-opacity = 255;
    };

    # Caffeine configuration
    "org/gnome/shell/extensions/caffeine" = {
      countdown-timer = 0;
      indicator-position-max = 2;
      show-indicator = "only-active";
    };

    # Custom app hotkeys
    "org/gnome/shell/extensions/happy-appy-hotkey" = {
      app-0 = "Heynote";
      app-1 = "kitty";
      hotkey-0 = ["<Alt>space"];
      hotkey-1 = ["<Control>space"];
    };

    # Battery threshold configuration
    "org/gnome/shell/extensions/thinkpad-battery-threshold" = {
      color-mode = false;
      indicator-mode = "ACTIVE";
    };
  };
}
