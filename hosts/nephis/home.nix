{
  hostOptions,
  inputs,
  outputs,
  pkgs,
  ...
}: let
  opts = hostOptions;
in {
  imports = [
    # inputs.stylix.homeManagerModules.stylix
    # outputs.homeModules.hyprland-setup
    outputs.homeModules.nixvim
  ];

  programs = {
    librewolf.enable = true;
  };

  homeSettings = {
    nixvim.enable = true;
  };

  home.packages = with pkgs; [
    # qbittorrent

    ## Backup
    # restic
    # autorestic
    # rclone
    # exiftool

    lutris
    mangohud
    goverlay
    protonup-qt
    inputs.nix-gaming.packages.${pkgs.system}.wine-ge
    winetricks
  ];

  home.file = {};

  ## Services ##
  services.syncthing = {
    enable = true;
  };
  # programs.gpg.enable = true;
}
