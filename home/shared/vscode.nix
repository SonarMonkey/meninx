{
  config,
  pkgs,
  ...
}: {
  # Configure VSCode
  programs.vscode = {
    # Enable and basic settings
    enable = true;
    mutableExtensionsDir = false;

    # Default profile settings
    profiles.default = {
      # Disable update checking
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;

      # Extensions
      extensions = with pkgs; [
        vscode-extensions.christian-kohler.path-intellisense
        vscode-extensions.esbenp.prettier-vscode
        vscode-extensions.gruntfuggly.todo-tree
        vscode-extensions.jnoortheen.nix-ide
        vscode-extensions.kamadorueda.alejandra
        vscode-extensions.ms-vscode-remote.remote-ssh
        vscode-extensions.ms-vscode.cpptools-extension-pack
        vscode-extensions.oderwat.indent-rainbow
        vscode-extensions.yzhang.markdown-all-in-one
        vscode-extensions.davidanson.vscode-markdownlint
        vscode-extensions.dbaeumer.vscode-eslint
        vscode-extensions.ecmel.vscode-html-css
        vscode-extensions.editorconfig.editorconfig
        vscode-extensions.llvm-vs-code-extensions.vscode-clangd
        vscode-extensions.xaver.clang-format
        vscode-extensions.redhat.vscode-yaml
        vscode-extensions.timonwong.shellcheck
        vscode-extensions.ms-python.python
        vscode-extensions.ms-python.debugpy
        vscode-extensions.ms-python.vscode-pylance
        vscode-extensions.ms-python.pylint
        vscode-extensions.ms-python.black-formatter
        vscode-marketplace.karunamurti.tera
        vscode-marketplace.marlinfirmware.auto-build
        vscode-extensions.golang.go
        vscode-extensions.platformio.platformio-vscode-ide
      ];

      # General settings mostly taken from piousdeer
      userSettings = {
        # General settings
        "files.autoSave" = "off";
        "files.trimTrailingWhitespace" = true;
        "editor.detectIndentation" = true;

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
      };
    };
  };
}
