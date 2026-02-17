{
  inputs,
  self,
  lib,
  ...
}: let
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
      permittedInsecurePackages = [];
    };
    overlays = with self.overlays; [modifications];
  };
in {
  den.default = {
    nixos = {
      nix = let
        flakeInputs = lib.filterAttrs (_: v: lib.isType "flake" v) inputs;
      in {
        # gc.automatic = true;
        settings = {
          experimental-features = ["nix-command" "flakes"];
          flake-registry = "/etc/nix/registry.json";
          # use-xdg-base-directories = true;
          keep-outputs = true;
          keep-derivations = true;
          auto-optimise-store = true;
          builders-use-substitutes = true;
          trusted-users = ["root" "@wheel"];
        };
        channel.enable = false;
        # registry.nixpkgs.flake = inputs.nixpkgs;
        # make flake registry and nix path match flake inputs:
        # pin the registry to avoid downloading and evaling a new nixpkgs version every time
        registry = lib.mkForce (lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs);
        # set the path for channels compat
        nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
      };

      inherit nixpkgs;
      # for hm as nixos module. use same nixpkgs instance as above
      home-manager.useUserPackages = true;
      home-manager.useGlobalPkgs = true;
    };

    homeManager = {
      # for hm as standalone
      # doesn't work: disabled when using useGlobalPkgs
      # inherit nixpkgs;
    };
  };
}
