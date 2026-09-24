{
  den,
  __findFile,
  ...
}: {
  ig.system.provides = {
    default.includes = [
      # <ig/boot/...> # include module for choice of bootloader in hosts' config
      <ig/networking>
      <ig/apps/coreutils>
      <ig/apps/nh>
      <ig/apps/git>
    ];

    workstation.includes = [
      <ig/system/default>
      <ig/sound>
    ];

    desktop.includes = [
      <ig/system/workstation>
    ];

    laptop.includes = [
      <ig/system/workstation>
    ];

    server.includes = [
      <ig/system/default>
    ];
  };
}
