{
  lib,
  stdenv,
  fetchzip,
  alsa-lib,
  autoPatchelfHook,
  libglvnd,
  libjack2,
  libX11,
  libXi,
  makeWrapper,
  makeDesktopItem,
  fetchurl,
  SDL2,
}: let
  platforms = {
    "x86_64-linux" = "linux_x86_64";
    "i686-linux" = "linux_x86";
    "aarch64-linux" = "linux_arm64";
    "armv7l-linux" = "arm_armhf_raspberry_pi";
    "x86_64-darwin" = "macos";
    "aarch64-darwin" = "macos";
  };
  bindir = platforms."${stdenv.hostPlatform.system}" or (throw "Unsupported system: ${stdenv.hostPlatform.system}");
in
  stdenv.mkDerivation (finalAttrs: {
    pname = "sunvox";
    version = "2.1.2";

    src = fetchzip {
      url = "https://www.warmplace.ru/soft/sunvox/sunvox-${finalAttrs.version}.zip";
      hash = "sha256-8HvMCKxSUWaR9I4kZSx2JtYmKBgoqLeH+SOstKrhETU=";
    };

    icon = fetchurl {
      url = "https://warmplace.ru/soft/sunvox/images/icon.png";
      hash = "sha256-ld2GCOhBhMThuUYBNa+2iTdY2HsYBRyApWiHTPuVgKA=";
    };

    nativeBuildInputs =
      lib.optionals stdenv.hostPlatform.isLinux [
        autoPatchelfHook
      ]
      ++ lib.optionals stdenv.hostPlatform.isDarwin [
        makeWrapper
      ];

    buildInputs = lib.optionals stdenv.hostPlatform.isLinux [
      alsa-lib
      libglvnd
      libX11
      libXi
      SDL2
    ];

    runtimeDependencies = lib.optionals stdenv.hostPlatform.isLinux [
      libjack2
    ];

    dontConfigure = true;
    dontBuild = true;

    installPhase =
      ''
        runHook preInstall

        # Delete platform-specific data for all the platforms we're not building for
        find sunvox -mindepth 1 -maxdepth 1 -type d -not -name "${bindir}" -exec rm -r {} \;

        mkdir -p $out/{bin,share/sunvox}
        mv * $out/share/sunvox/

      ''
      + lib.optionalString stdenv.hostPlatform.isLinux ''
        for binary in $(find $out/share/sunvox/sunvox/${bindir}/ -type f -executable); do
          mv $binary $out/bin/$(basename $binary)
        done

        # Cleanup, make sure we didn't miss anything
        find $out/share/sunvox/sunvox -type f -name readme.txt -delete
        rmdir $out/share/sunvox/sunvox/${bindir} $out/share/sunvox/sunvox

        # Place desktop item
        mkdir -p "$out/share"
        ln -s "${finalAttrs.desktopItem}/share/applications" "$out/share/applications"
      ''
      + lib.optionalString stdenv.hostPlatform.isDarwin ''
        mkdir $out/Applications
        ln -s $out/share/sunvox/sunvox/${bindir}/SunVox.app $out/Applications/
        ln -s $out/share/sunvox/sunvox/${bindir}/reset_sunvox $out/bin/

        # Need to use a wrapper, binary checks for files relative to the path it was called via
        makeWrapper $out/Applications/SunVox.app/Contents/MacOS/SunVox $out/bin/sunvox
      ''
      + ''

        runHook postInstall
      '';

    desktopItem = makeDesktopItem {
      name = finalAttrs.pname;
      desktopName = "SunVox";
      genericName = "Sequencer Synthesizer";
      comment = finalAttrs.meta.description;
      categories = ["AudioVideo" "Audio" "Music" "Midi" "Sequencer"];
      icon = "${finalAttrs.icon}";
      startupWMClass = "SunVox";
      exec = "sunvox_opengl";
    };

    meta = with lib; {
      description = "Small, fast and powerful modular synthesizer with pattern-based sequencer";
      license = licenses.unfreeRedistributable;
      sourceProvenance = with sourceTypes; [binaryNativeCode];
      homepage = "https://www.warmplace.ru/soft/sunvox/";
      maintainers = with maintainers; [puffnfresh OPNA2608];
      platforms = lib.attrNames platforms;
    };
  })
