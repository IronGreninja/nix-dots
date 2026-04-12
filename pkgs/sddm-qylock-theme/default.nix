let
  drv = {
    stdenvNoCC,
    kdePackages,
    lib,
    unzip,
    requireFile,
    fetchFromGitHub,
    selected_themes ? [],
    pin,
  }: let
    themes = import ./_themes.nix;
    knownThemes = builtins.attrNames themes;
    selectedThemes =
      if (selected_themes == [])
      then knownThemes
      else let
        unknown = lib.subtractLists knownThemes selected_themes;
      in
        if (unknown != [])
        then throw "Unknown theme(s): ${lib.concatStringsSep " " unknown}"
        else selected_themes;

    themesWithFonts = lib.filter (t: themes.${t} ? font) selectedThemes;
    requiredFonts = lib.forEach themesWithFonts (t:
      requireFile {
        inherit (themes.${t}.font) name url sha256;
      });
  in
    stdenvNoCC.mkDerivation rec {
      name = "sddm-qylock-theme";

      src = fetchFromGitHub {
        inherit (pin.repository) owner repo;
        inherit (pin) hash;
        rev = pin.revision;
      };

      srcs = requiredFonts;

      nativeBuildInputs = [unzip];

      # propagatedUserEnvPkgs = with kdePackages; [qtdeclarative qt5compat qtsvg qtmultimedia];
      propagatedBuildInputs = with kdePackages; [qtdeclarative qt5compat qtsvg qtmultimedia];

      dontWrapQtApps = true;

      installPhase = let
        themeDir = "$out/share/sddm/themes";
      in ''
        mkdir -p ${themeDir}
        for theme in ${toString selectedThemes}; do
          cp -r $src/themes/$theme ${themeDir}
        done

        # mkdir -p $out/share/fonts
        #
        # for src in $srcs; do
        #   # Get the actual filename from the store path (strips the hash)
        #   # We use 'requireFile' name attribute, but in the store it looks like /nix/store/hash-name
        #   filename=$(stripHash $src)
        #
        #   if [[ "$filename" == *.zip ]]; then
        #     echo "Extracting fonts from zip: $filename"
        #     # Create a temp directory to avoid cluttering the build root
        #     mkdir -p temp_ext
        #     unzip -j "$src" -d temp_ext  # -j junk paths (don't recreate zip folder structure)
        #
        #     # Move only font files
        #     find temp_ext -type f \( -iname "*.otf" -o -iname "*.ttf" \) -exec cp {} $out/share/fonts/ \;
        #     rm -rf temp_ext
        #   elif [[ "$filename" == *.otf || "$filename" == *.ttf ]]; then
        #     echo "Copying raw font: $filename"
        #     cp "$src" "$out/share/fonts/"
        #   fi
        # done
      '';

      meta = with lib; {
        description = "A cozy collection of sddm themes";
        homepage = "https://github.com/Darkkal44/qylock";
        license = licenses.gpl3;
        platforms = platforms.linux;
      };
    };
in
  {npins, ...}: {
    perSystem = {pkgs, ...}: {
      packages.sddm-qylock-theme = pkgs.callPackage drv {pin = npins.qylock;};
    };
  }
