{
  stdenvNoCC,
  fetchFromGitHub,
  wrapQtAppsHook,
  qtgraphicaleffects,
  qtquickcontrols2,
  qtsvg,
}: let
  bg = ./vergil.jpg;
  share = "share/sddm/themes";
in
  stdenvNoCC.mkDerivation rec {
    name = "sddm-vergil-dark-theme";

    src = fetchFromGitHub {
      owner = "MarianArlt";
      repo = "sddm-sugar-dark";
      rev = "ceb2c455663429be03ba62d9f898c571650ef7fe";
      hash = "sha256-flOspjpYezPvGZ6b4R/Mr18N7N3JdytCSwwu6mf4owQ=";
    };

    propagatedUserEnvPkgs = [
      qtgraphicaleffects
      qtquickcontrols2
      qtsvg
    ];

    buildInputs = [wrapQtAppsHook];

    dontBuild = true;

    installPhase = ''
      mkdir -p $out/${share}/${name}
      cp -r $src/* $out/${share}/${name}/
      rm $out/${share}/${name}/Background.jpg
      cp ${bg} $out/${share}/${name}/Background.jpg
      sed -i 's/#444/#0f1011/g' $out/${share}/${name}/Main.qml
    '';
  }
