{
  __findFile,
  den,
  ...
}: let
  N = "igreninja";
  userCfg = {
    git.name = "IronGreninja";
    git.email = "92992745+IronGreninja@users.noreply.github.com";
  };
in {
  den.aspects.${N} = {
    includes = [
      <den/primary-user>
      <ig/shell/zsh>
      <ig/apps/editor/neovim>
      <ig/fonts>
    ];

    nixos.users.users.${N} = {
      openssh.authorizedKeys.keys = [
      ];
      extraGroups = [
        "wireshark"
      ];
    };
  };

  den.hosts.x86_64-linux.nero.users.${N} = userCfg;
  den.hosts.x86_64-linux.nephis.users.${N} = userCfg;
}
