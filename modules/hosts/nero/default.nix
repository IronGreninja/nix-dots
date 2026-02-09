{self, ...}: let
  username = "igreninja";
  host = "nero";
  system = "x86_64-linux";
in {
  flake.nixosConfigurations = self.lib.mkNixos system host;
  flake.homeConfigurations = self.lib.mkHomeManager system host username;

  flake.modules.homeManager.${host} = {};

  flake.modules.nixos.${host} = {
    imports = with self.modules; [
      # Users on this host
      nixos.${username}
    ];
  };
}
