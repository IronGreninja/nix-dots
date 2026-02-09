{
  self,
  inputs,
  lib,
  ...
}: {
  # Helper functions for creating system / home-manager configurations

  options.flake.lib = lib.mkOption {
    type = lib.types.attrsOf lib.types.unspecified;
    default = {};
  };

  config.flake.lib = {
    mkNixos = system: name: {
      ${name} = inputs.nixpkgs.lib.nixosSystem {
        modules = with self.modules; [
          nixos.default
          nixos.${name}
          {nixpkgs.hostPlatform = lib.mkDefault system;}
          {networking.hostName = name;}
        ];
      };
    };

    mkHomeManager = system: host: name: {
      "${name}@${host}" = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.${system};
        modules = with self.modules; [
          homeManager.default
          homeManager.${name}
          homeManager.${host}
          generic.nixpkgs
        ];
      };
    };
  };
}
