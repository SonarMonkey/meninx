{
  fetchFromGitHub,
  lib,
}:
# FIXME figure out how to also add the "img" repository
fetchFromGitHub rec {
  pname = "dnd-tools";
  version = "main";

  owner = "5etools-mirror-2";
  repo = "5etools-mirror-2.github.io";
  rev = "main";
  hash = "sha256-jCAwaLYsLv4yWoosGI2+nhK45vzM30aKyEm5O6rCbyQ=";

  meta = with lib; {
    description = "A suite of browser-based tools for players and DMs of D&D 5e";
    homepage = "https://5e.tools";
    changelog = "https://github.com/5etools-mirror-2/5etools-mirror-2.github.io/releases/latest";
    license = [licenses.mit];
    maintainers = with maintainers; [urandom];
  };
}
