{
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "beaver-notes";
  version = "3.1.1";

  src = fetchFromGitHub {
    owner = "Daniele-rolli";
    repo = "Beaver-Notes";
    rev = version;
    hash = "sha256-3QG7m9ClQI3aKTPYPcR1ZB+w1ZzPX9bTUUNY692HWvk=";
  };

  meta = with lib; {
    description = "Your Personal Note-Taking Haven for Privacy and Efficiency";
    homepage = "https://github.com/Daniele-rolli/Beaver-Notes";
    license = licenses.mit;
    maintainers = with maintainers; [];
    mainProgram = "beaver-notes";
    platforms = platforms.all;
  };
}
