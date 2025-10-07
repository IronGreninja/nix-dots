{
  stdenvNoCC,
  kdePackages,
  lib,
  fetchFromGitHub,
  formats,
  themeName ? "astronaut",
  themeConfig ? null,
}:
stdenvNoCC.mkDerivation rec {
  name = "sddm-astronaut-theme";

  src = fetchFromGitHub {
    owner = "Keyitdev";
    repo = "sddm-astronaut-theme";
    rev = "c10bd950544036c7418e0f34cbf1b597dae2b72f";
    hash = "sha256-ITufiMTnSX9cg83mlmuufNXxG1dp9OKG90VBZdDeMxw=";
  };

  propagatedUserEnvPkgs = with kdePackages; [qtsvg qtmultimedia qtvirtualkeyboard];

  dontWrapQtApps = true;

  installPhase = let
    themeDir = "$out/share/sddm/themes/${name}";
    substituteStrP = "ConfigFile=Themes/";
    user-cfg = (formats.ini {}).generate "${themeName}.conf.user" themeConfig;
  in
    ''
      mkdir -p ${themeDir}
      cp -r $src/* ${themeDir}

      # mv fonts
      mkdir $out/share/fonts
      chmod -R 755 ${themeDir}/Fonts
      mv ${themeDir}/Fonts/* $out/share/fonts
    ''
    + lib.optionalString (themeName != "astronaut") ''
      substituteInPlace "${themeDir}/metadata.desktop" \
        --replace-fail \
        "${substituteStrP}astronaut.conf" \
        "${substituteStrP}${themeName}.conf"
    ''
    + lib.optionalString (lib.isAttrs themeConfig) ''
      # Link theme overrides
      chmod 755 ${themeDir}/Themes
      ln -sf ${user-cfg} "${themeDir}/Themes/${themeName}.conf.user"
    '';

  meta = with lib; {
    description = "Series of modern looking themes for SDDM";
    homepage = "https://github.com/Keyitdev/sddm-astronaut-theme";
    license = licenses.gpl3;
    platforms = platforms.linux;
  };
}
