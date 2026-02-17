{__findFile, ...}: let
  H = "nero";
in {
  den.hosts.x86_64-linux.${H} = {
    type = "desktop";
    theme = "horizon-dark";
  };

  den.aspects.${H} = {
    includes = [
      <ig/system/desktop>
      <ig/de/plasma>
    ];

    nixos = {pkgs, ...}: {
    };

    homeManager = {pkgs, ...}: {
      programs = {
        vesktop.enable = true;
      };

      # homeSettings.nvim.packageNames = ["nvim-test"];

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

      ## Services ##
      services.syncthing = {
        enable = true;
      };
      services.easyeffects.enable = true;
    };
  };
}
