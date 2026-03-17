{__findFile, ...}: {
  ig.system._.default.includes = [
    <ig/apps/coreutils>
    <ig/apps/nh>
    <ig/apps/git>
  ];

  ig.system._.workstation.includes = [
    <ig/apps/browser/librewolf>
  ];
}
