{self, ...}: {
  flake.modules.homeManager.nero = {
    pkgs,
    config,
    lib,
    ...
  }: let
  in {
    imports = with self.modules.homeManager; [
      cli
      ssh
      neovim

      librewolf
      vscopium
      kitty
      gaming

      fonts
      stylix
      kdeplasma
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

    homeSettings.nvim.packageNames = ["nvim-test"];

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
      ungoogled-chromium

      # mars-mips

      rnote
      krita
      xournalpp

      qpwgraph
    ];

    home.file = {};

    ## Services ##
    services.syncthing = {
      enable = true;
    };
    services.easyeffects.enable = true;
    # programs.gpg.enable = true;
  };
}
