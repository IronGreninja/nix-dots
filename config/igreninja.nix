{
  inputs,
  __findFile,
  den,
  ...
}: let
  N = "igreninja";
in {
  den.aspects.${N} = {
    includes = [
      <den/primary-user>
      <ig/shell/zsh>
      <ig/apps/editor/neovim>
      <ig/fonts>
    ];

    git.name = "IronGreninja";
    git.email = "92992745+IronGreninja@users.noreply.github.com";

    user = {
      # nixos.users.users.${N} = {
      openssh.authorizedKeys.keys = [
      ];
      extraGroups = [
      ];
    };
  };

  den.hosts.x86_64-linux.nero.users.${N} = {};
  den.hosts.x86_64-linux.nephis.users.${N} = {};
}
