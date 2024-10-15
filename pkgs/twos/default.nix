{
  stdenv,
  lib,
  makeWrapper,
  fetchurl,
  glib,
  nss,
  nspr,
  at-spi2-atk,
  cups,
  dbus,
  libdrm,
  gtk3,
  pango,
  cairo,
  xorg,
  mesa,
  expat,
  libxkbcommon,
  alsa-lib,
}:
stdenv.mkDerivation rec {
  name = "twos";
  version = "6.7.0";

  src = fetchurl {
    url = "https://twos.s3.us-west-2.amazonaws.com/mac/Twos-${version}.deb";
    sha256 = "";
  };
  sourceRoot = ".";
  unpackCmd = "dpkg-deb -x Twos-${version}.deb .";

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp -R usr/share opt $out/

    substituteInPlace $out/share/applications/twos.desktop --replace /opt/ $out/opt/
    ln -s $out/opt/Twos/twos $out/bin/twos

    runHook postInstall
  '';

  preFixup = let
    libPath = lib.makeLibraryPath [
      glib
      nss
      nspr
      at-spi2-atk
      cups.lib
      dbus.lib
      libdrm
      gtk3
      pango
      cairo
      xorg.libX11
      xorg.libXcomposite
      xorg.libXdamage
      xorg.libXext
      xorg.libXfixes
      xorg.libXrandr
      xorg.libxcb
      mesa
      expat
      libxkbcommon
      alsa-lib
    ];
  in ''
    patchelf \
      --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
      --set-rpath "${libPath}" \
      $out/opt/Twos/twos
  '';

  meta = with lib; {
    homepage = "https://www.twosapp.com/";
    description = "Twos: Remember & Share *Things*";
    license = licenses.unfree;
    platforms = platforms.linux;
    maintainers = [SonarMonkey];
    mainProgram = "twos";
  };
}
