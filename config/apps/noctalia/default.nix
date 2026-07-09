{flakeDir, ...}: {
  ig.apps._.noctalia = {
    homeManager = {
      inputs',
      pkgs,
      config,
      ...
    }: {
      home.packages = with pkgs; [
        inputs'.noctalia.packages.default
        evtest # bongocat plugin for noctalia
      ];

      xdg.configFile = {
        "noctalia/config.toml".source = config.lib.file.mkOutOfStoreSymlink "${flakeDir}/config/apps/noctalia/config.toml";
        "noctalia/lockscreen.toml".source = config.lib.file.mkOutOfStoreSymlink "${flakeDir}/config/apps/noctalia/lockscreen.toml";
      };
    };

    user.extraGroups = ["input"]; # bongocat(evtest)
  };
}
