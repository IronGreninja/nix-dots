# fixme
# https://github.com/nix-community/nh/issues/645
# https://github.com/nix-community/nh/issues/642
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
