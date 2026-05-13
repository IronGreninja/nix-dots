{__findFile, ...}: {
  ig.system.provides = {
    default.includes = [
      <ig/boot>
      <ig/networking>
    ];

    workstation.includes = [
      <ig/system/default>
      <ig/sound>
      <ig/boot/graphical>
    ];

    desktop.includes = [
      <ig/system/workstation>
    ];

    laptop.includes = [
      <ig/system/workstation>
    ];
  };
}
