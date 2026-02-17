{__findFile, ...}: let
  H = "nephis";
in {
  den.hosts.x86_64-linux.${H} = {
    type = "laptop";
    theme = "gruvbox-material-dark-hard";
  };

  den.aspects.${H} = {
    includes = [
      <ig/system/laptop>
      <ig/de/plasma>
    ];

    nixos = {pkgs, ...}: {
      # programs.noisetorch.enable = true;
      programs.steam = {
        enable = true;
      };
      programs.gamemode.enable = true;
      programs.gamescope.enable = true;
    };

    homeManager = {pkgs, ...}: {
      # services.syncthing = {
      #   enable = true;
      # };
      # programs.gpg.enable = true;
    };
  };
}
