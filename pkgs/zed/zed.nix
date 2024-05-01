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
  version = "0.133.5";

  src = fetchFromGitHub {
    owner = "zed-industries";
    repo = "zed";
    rev = "v${version}";
    hash = "sha256-52vWOlaxVcjlKLrBW+anh6i7kfBCD5cTHWcjLFiY9BA=";
    fetchSubmodules = true;
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "async-pipe-0.1.3" = "sha256-g120X88HGT8P6GNCrzpS5SutALx5H+45Sf4iSSxzctE=";
      "blade-graphics-0.4.0" = "sha256-S1PNdQ9YbJgLLsJU1mvDZ3feVDIrZGwU37JqIm+kfcE=";
      "font-kit-0.11.0" = "sha256-+4zMzjFyMS60HfLMEXGfXqKn6P+pOngLA45udV09DM8=";
      "heed-0.20.0-alpha.9" = "sha256-8bzoMmfKS+6AmeTzh0/F7WM9OBdIex+NYFER28bpA/s=";
      "lsp-types-0.94.1" = "sha256-kplgPsafrgZFMI1D9pQCwmg+FKMn5HNWLbcgdXHUFVU=";
      "nvim-rs-0.6.0-pre" = "sha256-bdWWuCsBv01mnPA5e5zRpq48BgOqaqIcAu+b7y1NnM8=";
      "pathfinder_simd-0.5.3" = "sha256-bakBcAQZJdHQPXybe0zoMzE49aOHENQY7/ZWZUMt+pM=";
      "taffy-0.3.11" = "sha256-0hXOEj6IjSW8e1t+rvxBFX6V9XRum3QO2Des1XlHJEw=";
      "tree-sitter-0.20.100" = "sha256-xZDWAjNIhWC2n39H7jJdKDgyE/J6+MAVSa8dHtZ6CLE=";
      "tree-sitter-bash-0.20.4" = "sha256-VP7rJfE/k8KV1XN1w5f0YKjCnDMYU1go/up0zj1mabM=";
      "tree-sitter-cpp-0.20.0" = "sha256-2QYEFkpwcRmh2kf4qEAL2a5lGSa316CetOhF73e7rEM=";
      "tree-sitter-css-0.19.0" = "sha256-5Qti/bFac2A1PJxqZEOuSLK3GGKYwPDKAp3OOassBxU=";
      "tree-sitter-elixir-0.1.0" = "sha256-hBHqQ3eBjknRPJjP+lQJU6NPFhUMtiv4FbKsTw28Bog=";
      "tree-sitter-go-0.19.1" = "sha256-5+L5QqVjZyeh+sKfxKZWrjIBFE5xM9KZlHcLiHzJCIA=";
      "tree-sitter-gomod-1.0.2" = "sha256-OPtqXe6OMC9c5dgFH8Msj+6DU01LvLKVbCzGLj0PnLI=";
      "tree-sitter-gowork-0.0.1" = "sha256-lM4L4Ap/c8uCr4xUw9+l/vaGb3FxxnuZI0+xKYFDPVg=";
      "tree-sitter-heex-0.0.1" = "sha256-6LREyZhdTDt3YHVRPDyqCaDXqcsPlHOoMFDb2B3+3xM=";
      "tree-sitter-jsdoc-0.20.0" = "sha256-fKscFhgZ/BQnYnE5EwurFZgiE//O0WagRIHVtDyes/Y=";
      "tree-sitter-json-0.20.0" = "sha256-fZNftzNavJQPQE4S1VLhRyGQRoJgbWA5xTPa8ZI5UX4=";
      "tree-sitter-markdown-0.0.1" = "sha256-F8VVd7yYa4nCrj/HEC13BTC7lkV3XSb2Z3BNi/VfSbs=";
      "tree-sitter-proto-0.0.2" = "sha256-W0diP2ByAXYrc7Mu/sbqST6lgVIyHeSBmH7/y/X3NhU=";
      "tree-sitter-typescript-0.20.2" = "sha256-cpOAtfvlffS57BrXaoa2xa9NUYw0AsHxVI8PrcpgZCQ=";
      "tree-sitter-yaml-0.0.1" = "sha256-S59jLlipBI2kwFuZDMmpv0TOZpGyXpbAizN3yC6wJ5I=";
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
    ZSTD_SYS_USE_PKG_CONFIG = true;
  };

  meta = with lib; {
    description = "Code at the speed of thought – Zed is a high-performance, multiplayer code editor from the creators of Atom and Tree-sitter";
    homepage = "https://github.com/zed-industries/zed";
    license = with licenses; [ asl20 agpl3Only gpl3Only ];
    maintainers = with maintainers; [ ];
    mainProgram = "zed";
  };
}
