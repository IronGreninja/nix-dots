{
  __findFile,
  inputs,
  ...
}: let
  Host = "maelle";
  User = "igreninja";
in {
  den.hosts.x86_64-linux.${Host} = {
    type = "laptop";
    theme = "gruvbox-material-dark-hard";

    users.${User} = {classes = ["homeManager"];};
  };

  den.aspects.${Host} = {
    includes = [
      <ig/boot/limine>
      <ig/system/laptop>
      <ig/de/plasma>
    ];
    nixos = {
      boot.loader.limine.secureBoot.enable = true;
    };
  };

  den.aspects.${User}.provides.${Host} = {
    includes = [
      <ig/system/laptop>
      <ig/de/plasma>
      <ig/apps/browser/zen>
    ];

    nixos = {pkgs, ...}: {
    };

    homeManager = {pkgs, ...}: {
      home.packages = with pkgs; [
        calibre
        obsidian
      ];
      services.syncthing.enable = true;
    };
  };
}
