{ lib
, buildGoModule
, fetchFromGitHub
, makeWrapper
, mpv
}:

buildGoModule rec {
  pname = "goanime";
  version = "1.8.7";

  src = fetchFromGitHub {
    owner = "alvarorichard";
    repo = "GoAnime";
    tag = "v${version}";
    # Two-pass: build once with fakeHash, copy the "got:" value from the error.
    hash = "sha256-KhnxqVjG1WdvPwBZVEqQBh9DpI1BZN7I2Uz43gG4Jpc=";
  };

  # No vendor/ directory upstream, so the module cache must be hashed too.
  vendorHash = "sha256-Nmq8OxkGt6EcWyNUPKGLoUkzBm7cmv3UhpvfoTEVoek=";

  subPackages = [ "cmd/goanime" ];

  doCheck = false;

  nativeBuildInputs = [ makeWrapper ];

  # mpv is a runtime dependency — wrap so it works without installing mpv globally.
  postFixup = ''
    wrapProgram $out/bin/goanime \
      --prefix PATH : ${lib.makeBinPath [ mpv ]}
  '';

  meta = {
    description = "CLI to browse, stream and download anime, with a TUI and pt-BR support";
    homepage = "https://github.com/alvarorichard/GoAnime";
    license = lib.licenses.mit;
    mainProgram = "goanime";
    platforms = lib.platforms.linux;
  };
}
