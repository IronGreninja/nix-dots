{
  ig.apps._.nh = {
    homeManager = {config, ...}: {
      programs.nh = {
        enable = true;
        flake = "${config.home.homeDirectory}/nix-dots";
      };
    };
  };
}
