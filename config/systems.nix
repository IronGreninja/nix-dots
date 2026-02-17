{
  den,
  __findFile,
  ...
}: {
  ig.system.provides = {
    default = den.lib.parametric.atLeast {
      includes = [
        <ig/boot>
        <ig/networking>
        <ig/sound>
      ];
    };

    desktop = den.lib.parametric.atLeast {
      includes = [
        <ig/system/default>
        <ig/boot/graphical>
      ];
    };

    laptop = den.lib.parametric.atLeast {
      includes = [
        <ig/system/default>
        <ig/boot/graphical>
      ];
    };
  };
}
