{
  stdenvNoCC,
  fetchFromGitHub,
  gtk-engine-murrine,
  gnome-themes-extra,
}:
stdenvNoCC.mkDerivation {
  name = "gruvbox-gtk-theme";

  src = fetchFromGitHub {
    owner = "Fausto-Korpsvart";
    repo = "Gruvbox-GTK-Theme";
    rev = "c0b7fb501938241a3b6b5734f8cb1f0982edc6b4";
    hash = "sha256-Y+6HuWaVkNqlYc+w5wLkS2LpKcDtpeOpdHnqBmShm5Q=";
  };

  propagatedUserEnvPkgs = [gtk-engine-murrine gnome-themes-extra]; # required by theme for correct rendering

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/themes
    cp -R $src/themes/* $out/share/themes
  '';
}
