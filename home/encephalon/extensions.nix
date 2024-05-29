{
  config,
  pkgs,
  lib,
  ...
}: {
  # GNOME extensions
  programs.gnome-shell = {
    enable = true;
    extensions = [
      # Built-in extensions
      {id = "user-theme@gnome-shell-extensions.gcampax.github.com";}
      {id = "windowsNavigator@gnome-shell-extensions.gcampax.github.com";}

      # User-added extensions
      {
        id = "AlphabeticalAppGrid@stuarthayhurst";
        package = "pkgs.gnomeExtensions.alphabetical-app-grid";
      }
      {
        id = "app-hider@lynith.dev";
        package = "pkgs.gnomeExtensions.app-hider";
      }
      {
        id = "caffeine@patapon.info";
        package = "pkgs.gnomeExtensions.caffeine";
      }
      {
        id = "grand-theft-focus@zalckos.github.com";
        package = "pkgs.gnomeExtensions.grand-theft-focus";
      }
      {
        id = "happy-appy-hotkey@jqno.nl";
        package = "pkgs.gnomeExtensions.happy-appy-hotkey";
      }
      {
        id = "thinkpad-battery-threshold@marcosdalvarez.org";
        package = "pkgs.gnomeExtensions.thinkpad-battery-threshold";
      }
    ];
  };
}
