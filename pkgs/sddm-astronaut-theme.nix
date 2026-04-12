let
  drv = {
    stdenvNoCC,
    kdePackages,
    lib,
    fetchFromGitHub,
    formats,
    themeName ? "astronaut",
    themeConfig ? null,
    pin,
  }:
    stdenvNoCC.mkDerivation rec {
      name = "sddm-astronaut-theme";

      src = fetchFromGitHub {
        inherit (pin.repository) owner repo;
        inherit (pin) hash;
        rev = pin.revision;
      };

      propagatedBuildInputs = with kdePackages; [qtsvg qtmultimedia qtvirtualkeyboard];

      dontWrapQtApps = true;
      dontBuild = true;

      installPhase = let
        themeDir = "$out/share/sddm/themes/${name}";
        substituteStrP = "ConfigFile=Themes/";
        user-cfg = (formats.ini {}).generate "${themeName}.conf.user" {General = themeConfig;};
      in
        ''
          runHook preInstall

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
        ''
        + ''runHook postInstall'';

      meta = with lib; {
        description = "Series of modern looking themes for SDDM";
        homepage = "https://github.com/Keyitdev/sddm-astronaut-theme";
        license = licenses.gpl3;
        platforms = platforms.linux;
      };
    };
in
  {npins, ...}: {
    perSystem = {pkgs, ...}: {
      packages.sddm-astronaut-theme = pkgs.callPackage drv {pin = npins.sddm-astronaut-theme;};
    };
  }
