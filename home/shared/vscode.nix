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
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      christian-kohler.path-intellisense
      esbenp.prettier-vscode
      kamadorueda.alejandra
      oderwat.indent-rainbow
      yzhang.markdown-all-in-one
      ms-vscode.cpptools-extension-pack
      ms-vscode-remote.remote-ssh
      vscode-extensions.gruntfuggly.todo-tree
    ];

    # General settings mostly taken from piousdeer
    userSettings = {
      # General settings
      "files.autoSave" = "off";
      "files.trimTrailingWhitespace" = true;
      "editor.detectIndentation" = true;
      "editor.fontLigatures" = true;
      "terminal.integrated.cursorBlinking" = true;
      "terminal.integrated.cursorStyle" = "line";
      "telemetry.telemetryLevel" = "off";
      "update.mode" = "off";
      "update.showReleaseNotes" = false;

      # Language settings
      "[nix]"."editor.tabSize" = 2;

      # Configure path autocomplete
      "path-intellisense.showHiddenFiles" = true;
      "path-intellisense.autoTriggerNextSuggestion" = true;

      # Appearance/UI settings
      "window.commandCenter" = true;
      "window.autoDetectColorScheme" = true;
    };
  };
}
