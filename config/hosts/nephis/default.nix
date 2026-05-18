{__findFile, ...}: let
  Host = "nephis";
  User = "igreninja";
in {
  den.hosts.x86_64-linux.${Host} = {
    type = "laptop";
    theme = "gruvbox-material-dark-hard";

    users.${User} = {classes = ["homeManager"];};
  };

  den.aspects.${Host} = {
    includes = [
      <ig/system/laptop>
      <ig/de/plasma>
    ];

    nixos = {pkgs, ...}: {
      services.flatpak.enable = true;
      programs = {
        gamemode.enable = true;
        gamescope.enable = true;
      };
    };
  };

  den.aspects.${User}.provides.${Host} = {
    includes = [
      <ig/system/laptop>
      <ig/de/plasma>
      <ig/stylix> # fixme: necessary becoz neovim module depends on it
    ];

    homeManager = {pkgs, ...}: {
      programs = {
        mangohud.enable = true;
        lutris = {
          enable = true;
          package = pkgs.lutris-free;
        };
      };
      home.packages = with pkgs; [
        wineWow64Packages.staging
        goverlay
        bottles
        heroic
        umu-launcher
        faugus-launcher
      ];
    };
  };
}
