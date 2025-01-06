{
  lib,
  appimageTools,
  fetchurl,
}: let
  pname = "heynote";
  version = "2.0.0";

  src = fetchurl {
    url = "https://github.com/heyman/heynote/releases/download/v${version}/Heynote_${version}_x86_64.AppImage";
    sha256 = "sha256-wMpOEEWJpkZtuyq8P8X+aFuUFx+HyKbhmPBaC80YxIo=";
  };

  appimageContents = appimageTools.extract {
    inherit pname version src;
  };
in
  appimageTools.wrapType2 rec {
    inherit pname version src;

    extraInstallCommands = ''
      install -m 444 -D ${appimageContents}/heynote.desktop $out/share/applications/heynote.desktop
      install -m 444 -D ${appimageContents}/usr/share/icons/hicolor/0x0/apps/heynote.png \
        $out/share/icons/hicolor/512x512/apps/heynote.png
      substituteInPlace $out/share/applications/heynote.desktop \
        --replace 'Exec=AppRun --no-sandbox %U' 'Exec=${pname}'
    '';

    meta = with lib; {
      description = "A dedicated scratchpad for developers";
      homepage = "https://github.com/heyman/heynote/";
      license = licenses.mit;
      maintainers = with maintainers; [];
      mainProgram = "heynote";
      platforms = platforms.all;
    };
  }
