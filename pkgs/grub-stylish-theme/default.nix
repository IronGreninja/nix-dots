let
  drv = {
    stdenvNoCC,
    fetchFromGitHub,
    src,
    ...
  }: let
    # url = "https://github.com/shvchk/poly-dark/blob/master/background.png";
    bg = ./polydark.jpg;
  in
    stdenvNoCC.mkDerivation {
      pname = "grub-stylish-theme";
      inherit (src) version;

      src = fetchFromGitHub {
        inherit (src.repository) owner repo;
        inherit (src) hash;
        rev = src.revision;
      };

      dontBuild = true;

      installPhase = ''
        runHook preInstall

        mkdir -p $out

        # Create placeholder terminal box PNGs that install.sh expects (copied from src repo derivation)
        mkdir -p common
        for box in c e n ne nw s se sw w; do
          touch common/terminal_box_$box.png
        done

        bash ./install.sh \
          --generate $out \
          --screen 1080p \
          --theme stylish \
          --icon white

        cp -f ${bg} $out/stylish/background.jpg

        runHook postInstall
      '';
    };
in
  {npins, ...}: {
    perSystem = {pkgs, ...}: {
      packages.grub-stylish-theme = pkgs.callPackage drv {src = npins.grub2-themes;};
    };
  }
