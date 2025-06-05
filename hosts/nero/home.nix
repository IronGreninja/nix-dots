{
  hostOptions,
  inputs,
  outputs,
  pkgs,
  system,
  config,
  ...
}: let
  opts = hostOptions;
in {
  imports = [
    outputs.homeModules.hyprland-setup
    outputs.homeModules.nixvim
    ./stylix.nix

    ./home/services/backup.nix
  ];

  programs = {
    librewolf.enable = true;
    kitty.enable = true;
    zellij.enable = true;
    vscode.enable = true;
    obs-studio.enable = true;
  };

  homeSettings = {
    installFonts = true;
    nixvim.enable = true;
    hyprland.enable = true;
  };

  # nixpkgs.config.android_sdk.accept_license = true;
  home.packages = with pkgs; [
    libreoffice-qt6-fresh
    devenv

    # android-studio

    # kde
    kdePackages.plasma-vault
    #

    calibre
    onlyoffice-bin_latest
    pdfarranger
    gimp
    oh-my-git

    # Backup
    restic
    autorestic
    rclone
    exiftool

    obsidian

    inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin

    libsForQt5.konversation
    gnome-sound-recorder
    qalculate-qt
    mpv

    qbittorrent

    ### Testing
    starship

    mars-mips

    # Gaming
    (lutris.override {
      extraLibraries = pkgs: [
        pkgs.curlWithGnuTls
      ];
      extraPkgs = pkgs: [
        pkgs.curlWithGnuTls
      ];
    })

    mangohud
    goverlay
    protonup-qt
    inputs.nix-gaming.packages.${pkgs.system}.wine-ge # builds instead of using cache
    winetricks
    xorg.xrdb # for steam
    xsettingsd

    prismlauncher
  ];

  home.file = {};

  ## Services ##
  services.syncthing = {
    enable = true;
  };
  # programs.gpg.enable = true;
}
