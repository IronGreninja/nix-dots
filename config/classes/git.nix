{
  den,
  lib,
  ...
}: let
  gitClass = {
    class,
    aspect-chain,
  }:
    den.batteries.forward {
      each = lib.singleton true;
      fromClass = _: "git";
      intoClass = _: "homeManager";
      intoPath = _: ["programs" "git" "settings" "user"];
      fromAspect = _: lib.head aspect-chain;
      adaptArgs = lib.id;
    };
in {
  # fixme: this errors. read docs for proper usage
  # den.schema.user.includes = [gitClass];
}
