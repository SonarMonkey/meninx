{ lib
, rustPlatform
, fetchFromGitHub
, curl
, pkg-config
, protobuf
, fontconfig
, freetype
, libgit2
, libxkbcommon
, openssl
, sqlite
, vulkan-loader
, zlib
, zstd
, stdenv
, darwin
, alsa-lib
, wayland
}:

rustPlatform.buildRustPackage rec {
  pname = "zed";
  version = "0.143.7";

  src = fetchFromGitHub {
    owner = "zed-industries";
    repo = "zed";
    rev = "v${version}";
    hash = "sha256-rqMD8xAVA8fdVFoeQ+TZiK0yPcxLJwGZW6+tOJ53jjU=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "alacritty_terminal-0.24.1-dev" = "sha256-aVB1CNOLjNh6AtvdbomODNrk00Md8yz8QzldzvDo1LI=";
      "ashpd-0.9.0" = "sha256-yq/6PN7cD9BD/RbKPM6ublrKBRYzeTc9NL0SYaeYMqA=";
      "async-pipe-0.1.3" = "sha256-g120X88HGT8P6GNCrzpS5SutALx5H+45Sf4iSSxzctE=";
      "blade-graphics-0.4.0" = "sha256-fvlHCN1EHbgg+aX7wHf10T+uEealIm9qRFLxgXjJbP8=";
      "cosmic-text-0.11.2" = "sha256-TLPDnqixuW+aPAhiBhSvuZIa69vgV3xLcw32OlkdCcM=";
      "font-kit-0.11.0" = "sha256-+4zMzjFyMS60HfLMEXGfXqKn6P+pOngLA45udV09DM8=";
      "lsp-types-0.95.1" = "sha256-N4MKoU9j1p/Xeowki/+XiNQPwIcTm9DgmfM/Eieq4js=";
      "nvim-rs-0.6.0-pre" = "sha256-bdWWuCsBv01mnPA5e5zRpq48BgOqaqIcAu+b7y1NnM8=";
      "pathfinder_simd-0.5.3" = "sha256-94/qS5d0UKYXAdx+Lswj6clOTuuK2yxqWuhpYZ8x1nI=";
      "tree-sitter-0.20.100" = "sha256-xZDWAjNIhWC2n39H7jJdKDgyE/J6+MAVSa8dHtZ6CLE=";
      "tree-sitter-go-0.20.0" = "sha256-/mE21JSa3LWEiOgYPJcq0FYzTbBuNwp9JdZTZqmDIUU=";
      "tree-sitter-gowork-0.0.1" = "sha256-lM4L4Ap/c8uCr4xUw9+l/vaGb3FxxnuZI0+xKYFDPVg=";
      "tree-sitter-heex-0.0.1" = "sha256-6LREyZhdTDt3YHVRPDyqCaDXqcsPlHOoMFDb2B3+3xM=";
      "tree-sitter-jsdoc-0.20.0" = "sha256-fKscFhgZ/BQnYnE5EwurFZgiE//O0WagRIHVtDyes/Y=";
      "tree-sitter-markdown-0.0.1" = "sha256-F8VVd7yYa4nCrj/HEC13BTC7lkV3XSb2Z3BNi/VfSbs=";
      "tree-sitter-proto-0.0.2" = "sha256-W0diP2ByAXYrc7Mu/sbqST6lgVIyHeSBmH7/y/X3NhU=";
      "xim-0.4.0" = "sha256-vxu3tjkzGeoRUj7vyP0vDGI7fweX8Drgy9hwOUOEQIA=";
    };
  };

  nativeBuildInputs = [
    curl
    pkg-config
    protobuf
    rustPlatform.bindgenHook
  ];

  buildInputs = [
    curl
    fontconfig
    freetype
    libgit2
    libxkbcommon
    openssl
    sqlite
    vulkan-loader
    zlib
    zstd
  ] ++ lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.AppKit
    darwin.apple_sdk.frameworks.CoreAudio
    darwin.apple_sdk.frameworks.CoreFoundation
    darwin.apple_sdk.frameworks.CoreGraphics
    darwin.apple_sdk.frameworks.CoreServices
    darwin.apple_sdk.frameworks.CoreText
    darwin.apple_sdk.frameworks.Foundation
    darwin.apple_sdk.frameworks.IOKit
    darwin.apple_sdk.frameworks.Metal
    darwin.apple_sdk.frameworks.Security
    darwin.apple_sdk.frameworks.SystemConfiguration
  ] ++ lib.optionals stdenv.isLinux [
    alsa-lib
    wayland
  ];

  env = {
    OPENSSL_NO_VENDOR = true;
  };

  meta = with lib; {
    description = "Code at the speed of thought – Zed is a high-performance, multiplayer code editor from the creators of Atom and Tree-sitter";
    homepage = "https://github.com/zed-industries/zed";
    license = with licenses; [ asl20 agpl3Only gpl3Only ];
    maintainers = with maintainers; [ ];
    mainProgram = "zed";
  };
}
