{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Basic configuration options
  fonts.fontconfig.enable = true;

  # Extra theme packages
  home.packages = with pkgs; [adw-gtk3];

  # Stylix options for Home Manager
  stylix = {
    # Target settings
    targets = {
      # Disable undesired targets
      emacs.enable = false;
      vscode.enable = false;

      # Enable the 256-color kitty variant
      kitty.variant256Colors = true;
    };

    # Cursor settings
    cursor = {
      package = pkgs.catppuccin-cursors.mochaLight;
      name = "Catppuccin-Mocha-Light-Cursors";
      size = 32;
    };

    # Font settings
    fonts = {
      sizes = {
        applications = 12;
        desktop = 12;
        popups = 12;
        terminal = 12;
      };
      serif = {
        package = pkgs.cantarell-fonts;
        name = "Cantarell";
      };
      sansSerif = {
        package = pkgs.cantarell-fonts;
        name = "Cantarell";
      };
      monospace = {
        package = pkgs.maple-mono-NF;
        name = "Maple Mono NF";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };
  };

  # VSCode theme settings
  programs.vscode = {
    # Theme extensions
    extensions = [
      pkgs.vscode-extensions.catppuccin.catppuccin-vsc
      pkgs.vscode-extensions.catppuccin.catppuccin-vsc-icons
    ];
    userSettings = {
      # Theme settings
      "workbench.colorTheme" = "Catppuccin Mocha";
      "workbench.iconTheme" = "catppuccin-mocha";

      # Additional theme-related config
      "catppuccin.workbenchMode" = "flat";
      "editor.semanticHighlighting.enabled" = true;
      "terminal.integrated.minimumContrastRatio" = 1;
    };
  };

  # Theme configs not defined by Nix or Home Manager
  home.file = {
    ".config/vesktop/settings/quickCss.css".text = ''
      @import url("https://catppuccin.github.io/discord/dist/catppuccin-mocha.theme.css");
    '';
  };
}
