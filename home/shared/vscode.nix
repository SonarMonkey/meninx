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
    extensions = with pkgs; [
      # Extensions from nix repo
      vscode-extensions.christian-kohler.path-intellisense
      vscode-extensions.esbenp.prettier-vscode
      vscode-extensions.gruntfuggly.todo-tree
      vscode-extensions.jnoortheen.nix-ide
      vscode-extensions.kamadorueda.alejandra
      vscode-extensions.ms-vscode-remote.remote-ssh
      vscode-extensions.ms-vscode.cpptools-extension-pack
      vscode-extensions.oderwat.indent-rainbow
      vscode-extensions.piousdeer.adwaita-theme
      vscode-extensions.yzhang.markdown-all-in-one
      vscode-extensions.davidanson.vscode-markdownlint
      vscode-extensions.dbaeumer.vscode-eslint
      vscode-extensions.ecmel.vscode-html-css
      vscode-extensions.editorconfig.editorconfig

      # Extensions from nix-vscode-extenions
      vscode-marketplace.karunamurti.tera
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
      "[html].editor.defaultFormatter" = "vscode.html-language-features";
      "[html].editor.tabSize" = 2;

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
