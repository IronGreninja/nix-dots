{
  config,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./nixpkgs.nix
    ./substituters.nix
  ];

  nix = let
    flakeInputs = lib.filterAttrs (_: v: lib.isType "flake" v) inputs;
  in {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      flake-registry = "/etc/nix/registry.json";

      # for direnv GC roots
      keep-derivations = true;
      keep-outputs = true;

      builders-use-substitutes = true;
      auto-optimise-store = true;

      trusted-users = ["root" "@wheel"];
    };
    # Opinionated: disable channels
    channel.enable = false;

    # make flake registry and nix path match flake inputs:
    # pin the registry to avoid downloading and evaling a new nixpkgs version every time
    registry = lib.mkForce (lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs);
    # set the path for channels compat
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };
}
