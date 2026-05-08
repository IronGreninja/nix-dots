{
  __findFile,
  den,
  inputs,
  ...
}: let
  H = "nero";
  mainUser = "igreninja";
in {
  den.hosts.x86_64-linux.${H} = {
    type = "desktop";
    theme = "horizon-dark";

    users.${mainUser} = {};
  };

  den.aspects.${H}.provides.${mainUser} = {
    includes = [
      # includes nixos + homeManager classes in aspects
      <ig/system/desktop>
      # <ig/de/plasma>
      # <ig/de/plasma/manager>
      <ig/wm/niri>
      <ig/stylix>
      <ig/apps/wireshark>
      <ig/apps/obs-studio>
      <ig/apps/vscopium>
      <ig/virt/qemu>
    ];

    nixos = {pkgs, ...}: {
      services.flatpak.enable = true;
    };

    homeManager = {pkgs, ...}: {
      programs = {
        vesktop.enable = true;
      };

      # nixpkgs.config.android_sdk.accept_license = true;
      home.packages = with pkgs; [
        inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
        pkgsStable.bottles # https://github.com/NixOS/nixpkgs/issues/514113 on unstable
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
