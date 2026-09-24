{
  getSystem,
  lib,
  ig,
  ...
}: {
  ig.boot.nixos.boot.loader = {
    timeout = 5;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
  };

  ig.boot._.grub = {
    includes = [ig.boot];
    nixos.boot.loader.grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
    };
  };

  ig.boot._.grub._.graphical = {
    includes = [ig.boot._.grub];
    nixos = {pkgs, ...}: {
      boot = {
        loader.grub = {
          gfxmodeEfi = "1920x1080";
          theme = let
            p = (getSystem pkgs.stdenv.hostPlatform.system).packages.grub-stylish-theme;
          in "${p}/stylish";
        };
        plymouth = {
          enable = true;
          theme = "black_hud";
          themePackages = [
            (pkgs.adi1090x-plymouth-themes.override {
              selected_themes = ["black_hud"];
            })
          ];
        };
        consoleLogLevel = 3;
        initrd.verbose = false;
        initrd.systemd.enable = true;
        kernelParams = [
          "quiet"
          "udev.log_level=3"
          "systemd.show_status=auto"
        ];
        loader.timeout = lib.mkForce 0;
      };
    };
  };

  ig.boot._.limine = {
    includes = [ig.boot];
    nixos = {pkgs, ...}: {
      boot.loader.limine = {
        enable = true;
        # needs manual steps before enabling (https://wiki.nixos.org/wiki/Limine#Secure_Boot)
        # secureBoot.enable = true;
      };
      environment.systemPackages = [pkgs.sbctl];
    };
  };
}
