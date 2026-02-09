{
  self,
  lib,
  ...
}: {
  config.flake.factory.user = username: isAdmin: {
    nixos."${username}" = {
      lib,
      pkgs,
      ...
    }: {
      users.users."${username}" = {
        isNormalUser = true;
        home = "/home/${username}";
        extraGroups = lib.optionals isAdmin [
          "wheel"
        ];
        shell = pkgs.zsh;
      };
      programs.zsh.enable = true; # required to set shell above
      # enable zsh autocompletion for system packages (systemd, etc)
      environment.pathsToLink = ["/share/zsh"];
    };

    homeManager."${username}" = {
      home.username = "${username}";
      home.homeDirectory = "/home/${username}";
    };
  };

  config.flake.factory.groupsToUsers = groups: users: {
    nixos = let
      forEachUser = lib.genAttrs users;
    in
      forEachUser (U: {
        users.users.${U}.extraGroups = groups;
      });
  };

  config.flake.factory.modifiedUsers = users: attrs: {
    nixos = let
      forEachUser = lib.genAttrs users;
    in
      forEachUser (U: {
        users.users.${U} = attrs;
      });
  };
}
