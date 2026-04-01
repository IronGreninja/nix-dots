{__findFile, ...}: let
  H = "nero";
  mainUser = "igreninja";
in {
  den.hosts.x86_64-linux.${H} = {
    type = "desktop";
    theme = "horizon-dark";

    users.${mainUser} = {};
  };

  # den.homes.x86_64-linux."${mainUser}@${H}" = {}; # doesn't work, apps not getting enabled

  den.aspects.${H} = {
    includes = [
      # includes nixos classes only
      <ig/system/desktop>
      <ig/de/plasma>
    ];

    nixos = {pkgs, ...}: {
      services.flatpak.enable = true;
    };

    provides.${mainUser} = {
      includes = [
        # includes nixos + homeManager classes
        <ig/system/desktop>
        <ig/de/plasma>
        <ig/apps/wireshark>
        <ig/apps/obs-studio>
        <ig/apps/vscopium>
        # <ig/virt/qemu> # virt-secret-init-encryption.service failed to start
        <ig/apps/waybar>
      ];

      homeManager = {pkgs, ...}: {
        programs = {
          vesktop.enable = true;
        };

        # nixpkgs.config.android_sdk.accept_license = true;
        home.packages = with pkgs; [
          qt6ct-kde
          bottles
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
  };
}
