{
  lib,
  appimageTools,
  fetchurl,
}: let
  pname = "twos";
  version = "6.7.0";

  src = fetchurl {
    url = "https://twos.s3.us-west-2.amazonaws.com/mac/Twos-${version}.AppImage";
    sha256 = "sha256-bUus1BOAynTqsUQz0fDtC1cQ7m21rMsczxjUpCWNXfY=";
  };

  appimageContents = appimageTools.extract {
    inherit pname version src;
  };
in
  appimageTools.wrapType2 rec {
    inherit pname version src;

    extraInstallCommands = ''
      install -m 444 -D ${appimageContents}/twos.desktop \
        $out/share/applications/twos.desktop
      install -m 444 -D ${appimageContents}/usr/share/icons/hicolor/512x512/apps/twos.png \
        $out/share/icons/hicolor/512x512/apps/twos.png
      substituteInPlace $out/share/applications/twos.desktop \
        --replace 'Exec=AppRun --no-sandbox %U' 'Exec=${pname}'
    '';

    meta = with lib; {
      description = "Twos: Remember & Share *Things*";
      homepage = "https://twosapp.com/";
      license = licenses.unfree;
      maintainers = with maintainers; [SonarMonkey];
      mainProgram = "twos";
      platforms = platforms.linux;
    };
  }
