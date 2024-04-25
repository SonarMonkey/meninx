{
  config,
  pkgs,
  ...
}: {
  # Emacs itself, use pgtk for native Wayland
  programs.emacs = {
    enable = true;
    package = pkgs.emacs29-pgtk;
  };

  # Add the doom executable to path
  home.sessionPath = ["$HOME/.config/emacs/bin"];

  # Dependencies, mostly for Doom
  # TODO check if I really need all these
  home.packages = with pkgs; [
    # Maybe a dependency of `nativecomp` features
    binutils

    # Dictionaries
    (aspellWithDicts (dicts: with dicts; [en en-computers en-science]))
    enchant
    hunspell

    # General doom dependencies
    ripgrep
    ripgrep-all
    fd
    zstd
    texlive.combined.scheme-medium
    gnupg

    # Treemacs
    python3

    # Org and friends
    imagemagick
    sqlite
    pandoc
    maim
    graphviz

    # Personal ledger
    beancount
    beancount-black
    fava

    # Other languages
    nodePackages.prettier # for nice formatting
    shellcheck # for shell script linting
    shfmt # for shell script formatting
    clojure # for clojure
    clj-kondo # for clojure
    cljfmt # for clojure
    html-tidy # for html formatting
    stylelint # for other web linting, css etc.
    nodePackages.js-beautify # for java and other web linting
    beancount-language-server # for plain text accounting
  ];
}
