{
  __findFile,
  den,
  inputs,
  ...
}: let
  Host = "nero";
  User = "igreninja";
in {
  den.hosts.x86_64-linux.${Host} = {
    type = "desktop";
    theme = "horizon-dark";

    users.${User} = {classes = ["homeManager"];};
  };

  den.aspects.${Host} = {
    includes = [
      <ig/system/desktop> # merges nixos class
      <ig/display-manager/ly>
    ];

    nixos = {pkgs, ...}: {
      imports = [
        inputs.nix-index-database.nixosModules.default
      ];
      programs.command-not-found.enable = false;
      services.flatpak.enable = true;
    };
  };

  den.aspects.${User}.provides.${Host} = {
    includes = [
      <ig/system/desktop> # merges homeManager class
      <ig/wm/niri>
      <ig/stylix>
      <ig/apps/wireshark>
      <ig/apps/obs-studio>
      <ig/apps/vscopium>
      <ig/virt/qemu>
    ];

    homeManager = {
      pkgs,
      inputs',
      ...
    }: {
      programs = {
        vesktop.enable = true;
      };

      # nixpkgs.config.android_sdk.accept_license = true;
      home.packages = with pkgs; [
        inputs'.zen-browser.packages.default
        bottles
        lutris-free
        # libreoffice-qt6-fresh
        devenv

        # android-studio

        # kde
        kdePackages.plasma-vault
        kdePackages.konversation
        kdePackages.krecorder
        # kdePackages.kamoso # camera app
        # kdePackages.neochat # insecure dep
        #

        calibre
        # onlyoffice-desktopeditors
        pdfarranger
        gimp3
        oh-my-git

        # Backup
        # restic
        # autorestic
        # rclone
        # exiftool

        obsidian

        # inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.osu-lazer-bin
        osu-lazer-bin

        qalculate-qt
        mpv

        qbittorrent

        ### Testing
        starship
        ungoogled-chromium
        sioyek

        # mars-mips

        # drawing + writing (tablet testing)
        # rnote
        # krita
        # xournalpp

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
