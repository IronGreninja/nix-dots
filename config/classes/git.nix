{
  den,
  lib,
  ...
}: let
  gitClass = {
    class,
    aspect-chain,
  }:
    den._.forward {
      each = lib.singleton true;
      fromClass = _: "git";
      intoClass = _: "homeManager";
      intoPath = _: ["programs" "git" "settings" "user"];
      fromAspect = _: lib.head aspect-chain;
      adaptArgs = lib.id;
    };
in {
  den.ctx.user.includes = [gitClass];
}
