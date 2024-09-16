{
  config,
  pkgs,
  lib,
  ...
}:
with lib.hm.gvariant; {
  # Configure dconf settings for GNOME
  dconf.settings = {
    # App folders
    "org/gnome/desktop/app-folders" = {
      folder-children = ["Utilities" "Office" "Media" "Fun" "Graphics" "KiCad" "Audio" "Productivity"];
    };

    # Default productivity applications
    "org/gnome/desktop/app-folders/folders/Productivity" = {
      apps = [
        "org.gnome.Calendar.desktop"
        "org.gnome.clocks.desktop"
        "org.gnome.Contacts.desktop"
        "simple-scan.desktop"
        "org.gnome.Geary.desktop"
      ];
      name = "Productivity";
      translate = true;
    };

    # Audio applications
    "org/gnome/desktop/app-folders/folders/Audio" = {
      apps = [
        "BespokeSynth.desktop"
        "carla.desktop"
        "carla-control.desktop"
        "com.github.wwmm.easyeffects.desktop"
        "org.pipewire.Helvum.desktop"
        "vcv-rack.desktop"
        "sunvox.desktop"
      ];
      name = "Audio";
      translate = true;
    };

    # KiCad applications
    "org/gnome/desktop/app-folders/folders/KiCad" = {
      apps = [
        "org.kicad.bitmap2component.desktop"
        "org.kicad.eeschema.desktop"
        "org.kicad.gerbview.desktop"
        "org.kicad.kicad.desktop"
        "org.kicad.pcbcalculator.desktop"
        "org.kicad.pcbnew.desktop"
      ];
      name = "KiCad";
      translate = true;
    };

    # Graphics applications
    "org/gnome/desktop/app-folders/folders/Graphics" = {
      apps = [
        "org.kde.krita.desktop"
        "scribus.desktop"
        "gimp.desktop"
        "org.inkscape.Inkscape.desktop"
        "io.gitlab.adhami3310.Converter.desktop"
        "aseprite.desktop"
      ];
      name = "Graphics";
      translate = true;
    };

    # Media applications
    "org/gnome/desktop/app-folders/folders/Media" = {
      apps = [
        "info.febvre.Komikku.desktop"
        "org.gnome.Music.desktop"
        "org.gnome.Totem.desktop"
        "vlc.desktop"
        "org.gabmus.gfeeds.desktop"
      ];
      name = "Media";
      translate = true;
    };

    # Game-related applications
    "org/gnome/desktop/app-folders/folders/Fun" = {
      apps = [
        "io.github.antimicrox.antimicrox.desktop"
        "com.usebottles.bottles.desktop"
        "OpenTabletDriver.desktop"
        "osu!.desktop"
        "org.freedesktop.Piper.desktop"
        "org.prismlauncher.PrismLauncher.desktop"
        "via-nativia.desktop"
        "steam.desktop"
        "Balatro.desktop"
        "io.github.Foldex.AdwSteamGtk.desktop"
        "io.github.benjamimgois.goverlay.desktop"
        "mudlet.desktop"
        "org.godotengine.Godot4.desktop"
        "SpaceCadetPinball.desktop"
      ];
      name = "Fun";
      translate = true;
    };

    # Libreoffice apps
    "org/gnome/desktop/app-folders/folders/Office" = {
      apps = [
        "startcenter.desktop"
        "base.desktop"
        "calc.desktop"
        "draw.desktop"
        "impress.desktop"
        "math.desktop"
        "writer.desktop"
      ];
      name = "Office";
      translate = true;
    };

    # System utilities
    "org/gnome/desktop/app-folders/folders/Utilities" = {
      apps = [
        "org.gnome.FileRoller.desktop"
        "org.gnome.Connections.desktop"
        "org.gnome.baobab.desktop"
        "org.gnome.DiskUtility.desktop"
        "org.gnome.Evince.desktop"
        "org.gnome.Loupe.desktop"
        "org.gnome.seahorse.Application.desktop"
        "org.gnome.tweaks.desktop"
        "gnome-abrt.desktop"
        "gnome-system-log.desktop"
        "nm-connection-editor.desktop"
        "org.gnome.DejaDup.desktop"
        "org.gnome.Dictionary.desktop"
        "org.gnome.fonts.desktop"
        "org.gnome.Usage.desktop"
        "vinagre.desktop"
        "io.gitlab.liferooter.TextPieces.desktop"
      ];
      categories = ["X-GNOME-Utilities"];
      name = "X-GNOME-Utilities.directory";
      translate = true;
    };

    # Make capslock ctrl
    "org/gnome/desktop/input-sources" = {
      sources = [(mkTuple ["xkb" "us"])];
      xkb-options = ["terminate:ctrl_alt_bksp" "caps:ctrl_modifier"];
    };

    # Set wallpaper and properties
    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/adwaita-l.jxl";
      picture-uri-dark = "file:///run/current-system/sw/share/backgrounds/gnome/adwaita-d.jxl";
      primary-color = "#3071AE";
      secondary-color = "#000000";
    };

    # Set screensaver and properties
    "org/gnome/desktop/screensaver" = {
      picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/adwaita-l.jxl";
      primary-color = "#3071AE";
      secondary-color = "#000000";
    };

    # General interface settings
    "org/gnome/desktop/interface" = {
      # Clock
      clock-format = "12h";
      clock-show-weekday = true;

      # Theme
      color-scheme = "prefer-dark";
      gtk-theme = "adw-gtk3-dark";
      cursor-theme = "Adwaita";

      # Font
      font-antialiasing = "rgba";
      font-hinting = "slight";
      font-name = "Cantarell 12";
      document-font-name = "Cantarell 12";
      monospace-font-name = "Maple Mono NF 12";
    };

    # Touchpad settings
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
    };

    # Disable mouse acceleration
    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
    };

    # My keybindings
    "org/gnome/desktop/wm/keybindings" = {
      activate-window-menu = [];
      close = ["<Shift><Super>q"];
      switch-applications = [];
      switch-applications-backward = [];
      switch-windows = ["<Alt>Tab"];
      switch-windows-backward = ["<Shift><Alt>Tab"];
    };

    # Window button layout
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
    };

    # Compositor/workspace settings
    "org/gnome/mutter" = {
      attach-modal-dialogs = true;
      dynamic-workspaces = true;
      edge-tiling = true;
      workspaces-only-on-primary = true;
    };

    # Settings daemon
    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-schedule-automatic = true;
    };

    # General shell configuration
    "org/gnome/shell" = {
      # Favorite apps for dash
      favorite-apps = [
        "firefox.desktop"
        "vesktop.desktop"
        "thunderbird.desktop"
        "mullvad-vpn.desktop"
        "org.gnome.Nautilus.desktop"
        "obsidian.desktop"
        "heynote.desktop"
        "code.desktop"
        "kitty.desktop"
        "org.gnome.Settings.desktop"
      ];
    };

    # Make that dumb popup go away
    "org/gnome/tweaks" = {show-extensions-notice = false;};
  };
}
