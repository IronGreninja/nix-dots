{
  den,
  __findFile,
  ...
}: {
  ig.podman = den.lib.parametric {
    includes = [<ig/virt/podman>];
  };
}
