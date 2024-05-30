{
  config,
  pkgs,
  ...
}: {
  # Configure VSCode
  programs.vscode = {
    # Enable and basic settings
    enable = true;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    mutableExtensionsDir = false;

    # Extensions
    extensions = [
      # Extensions from nix repo
      pkgs.vscode-extensions.christian-kohler.path-intellisense
      pkgs.vscode-extensions.esbenp.prettier-vscode
      pkgs.vscode-extensions.gruntfuggly.todo-tree
      pkgs.vscode-extensions.jnoortheen.nix-ide
      pkgs.vscode-extensions.kamadorueda.alejandra
      pkgs.vscode-extensions.ms-vscode-remote.remote-ssh
      pkgs.vscode-extensions.ms-vscode.cpptools-extension-pack
      pkgs.vscode-extensions.oderwat.indent-rainbow
      pkgs.vscode-extensions.piousdeer.adwaita-theme
      pkgs.vscode-extensions.yzhang.markdown-all-in-one

      # Extensions from nix-vscode-extenions
      #pkgs.vscode-marketplace.tabbyml.vscode-tabby
    ];

    # General settings mostly taken from piousdeer
    userSettings = {
      # General settings
      "files.autoSave" = "off";
      "files.trimTrailingWhitespace" = true;
      "editor.detectIndentation" = true;
      "editor.fontLigatures" = true;
      "editor.fontFamily" = "'Maple Mono NF', 'monospace', monospace";

      # Integrated terminal
      "terminal.integrated.cursorBlinking" = true;
      "terminal.integrated.cursorStyle" = "line";

      # Telemetry/updates
      "telemetry.telemetryLevel" = "off";
      "update.mode" = "off";
      "update.showReleaseNotes" = false;

      # Language settings
      "[nix]"."editor.tabSize" = 2;
      "[nix]"."editor.defaultFormatter" = "kamadorueda.alejandra";
      "[markdown]"."editor.defaultFormatter" = "esbenp.prettier-vscode";

      # Nix-IDE settings
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nixd";
      "nix.formatterPath" = "alejandra";

      # Configure path autocomplete
      "path-intellisense.showHiddenFiles" = true;
      "path-intellisense.autoTriggerNextSuggestion" = true;

      # Appearance/UI settings
      "editor.renderLineHighlight" = "none";
      "window.autoDetectColorScheme" = true;
      "window.commandCenter" = true;
      "workbench.tree.indent" = 12;

      # Theme settings
      "workbench.preferredDarkColorTheme" = "Adwaita Dark";
      "workbench.preferredLightColorTheme" = "Adwaita Light";
      "workbench.productIconTheme" = "adwaita";
      "workbench.iconTheme" = null;
    };
  };
}
