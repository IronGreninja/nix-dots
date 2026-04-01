{
  getSystem,
  lib,
  ig,
  ...
}: {
  ig.boot.nixos = {pkgs, ...}: {
    boot = {
      loader = {
        timeout = 5;
        efi = {
          canTouchEfiVariables = true;
          efiSysMountPoint = "/boot/efi";
        };
        grub = {
          enable = true;
          efiSupport = true;
          device = "nodev";
        };
      };
    };
  };

  ig.boot._.graphical = {
    includes = [ig.boot];
    nixos = {pkgs, ...}: {
      boot.loader.grub = {
        gfxmodeEfi = "1920x1080";
        useOSProber = true;
        theme = let
          p = (getSystem pkgs.stdenv.hostPlatform.system).packages.grub-stylish-theme;
        in "${p}/stylish";
      };
    };
  };

  ig.boot._.graphical._.plymouth = {
    includes = [ig.boot._.graphical];
    nixos = {pkgs, ...}: {
      boot = {
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
}
