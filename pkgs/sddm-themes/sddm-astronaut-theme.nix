{
  stdenvNoCC,
  qt6,
  lib,
  fetchFromGitHub,
  formats,
  themeName ? "astronaut",
  themeConfig ? null,
}: let
  user-cfg = (formats.ini {}).generate "${themeName}.conf.user" themeConfig;
in
  stdenvNoCC.mkDerivation rec {
    name = "sddm-astronaut-theme";

    src = fetchFromGitHub {
      owner = "Keyitdev";
      repo = "sddm-astronaut-theme";
      rev = "8f41a8365ac7b566086a664f2fbfb07ff7c87465";
      hash = "sha256-JoSOrTJJYThwCKSPBwj9exhejg/ASY6s9iDcJ+zn8ME=";
    };

    propagatedUserEnvPkgs = with qt6; [qtsvg qtmultimedia qtvirtualkeyboard];

    dontBuild = true;

    dontWrapQtApps = true;

    installPhase = ''
      themeDir="$out/share/sddm/themes/${name}"
      mkdir -p $themeDir
      cp -r $src/* $themeDir

      substituteInPlace "$themeDir/metadata.desktop" \
        --replace-fail \
        "ConfigFile=Themes/astronaut.conf" \
        "ConfigFile=Themes/${themeName}.conf"

      # mv fonts
      mkdir $out/share/fonts
      chmod -R 755 $themeDir/Fonts
      mv $themeDir/Fonts/* $out/share/fonts

      # Link theme overrides
      ${lib.optionalString (lib.isAttrs themeConfig) ''
        chmod 755 $themeDir/Themes
        ln -sf ${user-cfg} "$themeDir/Themes/${themeName}.conf.user"
      ''}
    '';

    meta = with lib; {
      description = "Series of modern looking themes for SDDM";
      homepage = "https://github.com/Keyitdev/sddm-astronaut-theme";
      license = licenses.gpl3;
      platforms = platforms.linux;
    };
  }
