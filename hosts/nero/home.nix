{
  hostOptions,
  inputs,
  outputs,
  pkgs,
  system,
  config,
  lib,
  ...
}: let
  opts = hostOptions;
in {
  imports = [
    ../../home/cli
    ../../home/git.nix
    ../../home/ssh.nix
    ../../home/neovim.nix

    ../../home/browsers/librewolf.nix
    ../../home/vscopium
    ../../home/kitty.nix
    ../../home/gaming.nix

    ../../home/fonts
    ../../home/stylix.nix
    ../../home/kdeplasma
  ];

  # issue: obs screen capture source missing (kde)
  # fix: https://github.com/NixOS/nixpkgs/issues/407809#issuecomment-2910213454
  # xdg.portal = {
  #   enable = true;
  #   extraPortals = with pkgs; [
  #     kdePackages.xdg-desktop-portal-kde
  #   ];
  #   config = {
  #     hyprland = {
  #       default = ["hyprland" "kde"];
  #       "org.freedesktop.impl.portal.FileChooser" = ["kde"];
  #     };
  #   };
  #   xdgOpenUsePortal = true;
  # };

  programs = {
    vesktop.enable = true;
    obs-studio.enable = true;
  };

  homeSettings = {
    nvim.packageNames = ["nvim-test"];
    # hyprland.enable = true;
  };

  # nixpkgs.config.android_sdk.accept_license = true;
  home.packages = with pkgs; [
    libreoffice-qt6-fresh
    devenv

    # android-studio

    # kde
    kdePackages.plasma-vault
    kdePackages.konversation
    kdePackages.krecorder
    # kdePackages.kamoso # camera app
    # kdePackages.neochat # insecure dep
    #

    code-cursor-fhs
    calibre
    onlyoffice-desktopeditors
    pdfarranger
    gimp3
    oh-my-git

    # Backup
    restic
    autorestic
    rclone
    exiftool

    obsidian

    # inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.osu-lazer-bin
    osu-lazer-bin

    qalculate-qt
    mpv

    qbittorrent

    ### Testing
    starship

    # mars-mips

    rnote
    krita
    xournalpp
  ];

  home.file = {};

  ## Services ##
  services.syncthing = {
    enable = true;
  };
  # programs.gpg.enable = true;
}
