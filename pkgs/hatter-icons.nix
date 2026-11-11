{ lib, stdenvNoCC, fetchFromGitHub, gtk3, rsync }:

stdenvNoCC.mkDerivation {
  pname = "hatter-icon-theme";
  version = "0-unstable-2026-11-10";

  src = fetchFromGitHub {
    owner = "Mibea";
    repo = "Hatter";
    rev = "32b4a519521696c38955e692e6ed7cf227fd5b76";
    # Two-pass: build once with fakeHash, copy the "got:" value from the error.
    hash = "sha256-QSxmWHFKziCR0rT5hU9QMMplAeQpC6W3+Pzn5nPdhbw=";
  };

  nativeBuildInputs = [ gtk3 rsync ];

  # Upstream links to one icon that doesn't exist (weather-clear-night).
  dontCheckForBrokenSymlinks = true;

  # The author's script generates every variant into ./Build.
  buildPhase = ''
    runHook preBuild
    bash Build-Hatter.sh
    runHook postBuild
  '';

  # Only the two Plasma variants; the dark one inherits from the other.
  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/icons
    cp -a Build/Hatter-kde Build/Hatter-kde-dark $out/share/icons/

    for theme in $out/share/icons/Hatter-kde $out/share/icons/Hatter-kde-dark; do
      # Small "places" icons are outlines for only some entries, which mixes
      # two styles in file-manager sidebars. Drop them so the coloured
      # scalable ones are used everywhere.
      rm -rf $theme/places/16 $theme/places/22 $theme/places/24

      # Built before the removals here, so it would list icons that are gone.
      rm -f $theme/icon-theme.cache

      # The theme has coloured art for only some session actions. Drop it so
      # the whole power menu uses outline icons.
      for name in system-lock-screen system-switch-user system-suspend system-suspend-hibernate system-hibernate; do
        find $theme -path '*scalable*' -name "$name.svg" -delete
      done
    done
    runHook postInstall
  '';

  meta = {
    description = "Hatter icon theme (Plasma variants), by Mibea";
    homepage = "https://github.com/Mibea/Hatter";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.all;
  };
}
