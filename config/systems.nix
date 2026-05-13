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
      ];
    };

    workstation = den.lib.parametric.atLeast {
      includes = [
        <ig/system/default>
        <ig/sound>
        <ig/boot/graphical>
      ];
    };

    desktop = den.lib.parametric.atLeast {
      includes = [
        <ig/system/workstation>
      ];
    };

    laptop = den.lib.parametric.atLeast {
      includes = [
        <ig/system/workstation>
      ];
    };

    server = den.lib.parametric.atLeast {
      includes = [
        <ig/system/default>
      ];
    };
  };
}
