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
    ./home/services/backup.nix
    inputs.nixCats.homeModules.default
  ];

  # issue: obs screen capture source missing (kde)
  # fix: https://github.com/NixOS/nixpkgs/issues/407809#issuecomment-2910213454
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      kdePackages.xdg-desktop-portal-kde
    ];
    config = {
      hyprland = {
        default = ["hyprland" "kde"];
        "org.freedesktop.impl.portal.FileChooser" = ["kde"];
      };
    };
    xdgOpenUsePortal = true;
  };

  programs = {
    librewolf.enable = true;
    kitty.enable = true;
    zellij.enable = true;
    vscode.enable = true;
    obs-studio.enable = true;
  };

  # services.mako.enable = lib.mkForce false;

  homeSettings = {
    installFonts = true;
    # nixvim.enable = true;
    nvim = {
      enable = true;
      packageNames = ["nvim" "nvim-test"];
    };
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

    # inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin
    osu-lazer-bin

    qalculate-qt
    mpv

    qbittorrent

    ### Testing
    starship

    # mars-mips

    # Gaming
    lutris
    # (lutris.override {
    #   extraLibraries = pkgs: [
    #     pkgs.curlWithGnuTls
    #   ];
    #   extraPkgs = pkgs: [
    #     pkgs.curlWithGnuTls
    #   ];
    # })

    mangohud
    goverlay
    protonup-qt
    wineWowPackages.stable
    winetricks
    # xorg.xrdb # for steam
    # xsettingsd

    # prismlauncher

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
