{
  stdenvNoCC,
  fetchFromGitHub,
  ...
}:
stdenvNoCC.mkDerivation {
  name = "gruvboxPlus-icon-theme";

  src = fetchFromGitHub {
    owner = "SylEleuth";
    repo = "gruvbox-plus-icon-pack";
    rev = "ac2ab46390976d9a1f1ca24aebea29b2b4329af3";
    hash = "sha256-Jayi7C6JtphT6HMiTh/5h84YZtO+7vHYkXyjtFpJHto=";
  };

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/icons
    cp -r $src/* $out/share/icons
  '';
}
