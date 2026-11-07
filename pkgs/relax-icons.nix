{ lib, stdenvNoCC, fetchFromGitHub }:

stdenvNoCC.mkDerivation {
  pname = "relax-light-icons";
  version = "0-unstable-2026-11-06";

  src = fetchFromGitHub {
    owner = "L4ki";
    repo = "Relax-Plasma-Themes";
    rev = "928d564e6205d5154a502b210abfb36a68f20643";
    # Two-pass: build once with fakeHash, copy the "got:" value from the error.
    hash = "sha256-dbm/fIObgtbdWDXAEvwlgJYG/iJTQMFLqp8BNyOECCc=";
  };

  dontBuild = true;
  # Icon themes often ship symlinks to icons that don't exist.
  dontCheckForBrokenSymlinks = true;

  # The repo bundles several themes; take only the light icon set.
  installPhase = ''
    runHook preInstall
    dir=$(find . -maxdepth 4 -type d -name Relax-Light-Icons | head -n1)
    [ -n "$dir" ] || { echo "Relax-Light-Icons not found in the repo"; exit 1; }
    mkdir -p $out/share/icons
    cp -r "$dir" $out/share/icons/
    runHook postInstall
  '';

  meta = {
    description = "Relax-Light icon theme for KDE Plasma, by L4ki";
    homepage = "https://github.com/L4ki/Relax-Plasma-Themes";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.all;
  };
}
