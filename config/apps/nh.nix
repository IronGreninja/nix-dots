{flakeDir, ...}: {
  ig.apps._.nh = {
    homeManager = {config, ...}: {
      programs.nh = {
        enable = true;
        flake = flakeDir;
      };
    };
  };
}
