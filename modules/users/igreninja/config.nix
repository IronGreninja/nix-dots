{
  self,
  lib,
  ...
}: let
  username = "igreninja";
in {
  flake.modules = lib.mkMerge [
    (self.factory.user username true)

    {
      nixos.${username} = {};

      homeManager.${username} = {
        programs.git.settings.user = {
          name = "IronGreninja";
          email = "92992745+IronGreninja@users.noreply.github.com";
        };
      };
    }
  ];
}
