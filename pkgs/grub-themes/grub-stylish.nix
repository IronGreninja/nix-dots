{
  stdenvNoCC,
  fetchFromGitHub,
  ...
}: let
  # bg = pkgs.fetchurl {
  #   url = "https://github.com/shvchk/poly-dark/blob/master/background.png";
  #   sha256 = "sha256-voTgRNiOb1eUljKA74jquMT/Z6ZcfTPKqbXXRbQWECc=";
  # };
  bg = ./polydark.jpg;
in
  stdenvNoCC.mkDerivation {
    name = "grub-stylish-theme";

    src = fetchFromGitHub {
      owner = "vinceliuice";
      repo = "grub2-themes";
      rev = "000171da277b8d0219f90782708d42c700081a44";
      hash = "sha256-KYwOOYAWsFNM5EGdauew5HOVj9HdWWGcjGy7mLX+V6w=";
    };

    dontBuild = true;

    installPhase = ''
      mkdir -p $out/
      bash $src/install.sh \
        --generate $out/ \
        --screen 1080p \
        --theme stylish \
        --icon white;
      rm $out/stylish/background.jpg
      cp ${bg} $out/stylish/background.jpg
    '';
  }
