{
  stdenv,
  lib,
  autoPatchelfHook,
  dpkg,
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
    sha256 = "sha256-Sqjs5EB8zUh5G8MzGnKJuUkOzxd0ARWOiV9Lqs0cZi8=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
    dpkg
    makeWrapper
  ];

  buildInputs = [
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

  dontConfigure = true;
  dontBuild = true;

  sourceRoot = ".";
  unpackCmd = "dpkg-deb -x $src .";

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp -R usr/share opt $out/

    substituteInPlace $out/share/applications/twos.desktop --replace /opt/ $out/opt/
    ln -s $out/opt/Twos/twos $out/bin/twos

    runHook postInstall
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
