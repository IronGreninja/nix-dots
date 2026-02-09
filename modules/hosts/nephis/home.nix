{self, ...}: {
  flake.modules.homeManager.nephis = {
    inputs,
    outputs,
    pkgs,
    ...
  }: let
  in {
    imports = with self.modules.homeManager; [
      cli
      ssh
      neovim

      librewolf

      gaming
    ];

    programs = {
    };

    home.packages = with pkgs; [
      # qbittorrent

      ## Backup
      # restic
      # autorestic
      # rclone
      # exiftool
    ];

    home.file = {};

    ## Services ##
    services.syncthing = {
      enable = true;
    };
    # programs.gpg.enable = true;
  };
}
