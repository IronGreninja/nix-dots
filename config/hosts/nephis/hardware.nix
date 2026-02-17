{
  den.aspects.nephis.nixos = {
    config,
    lib,
    pkgs,
    ...
  }: let
    mountOpts = ["compress=zstd" "noatime"];
  in {
    boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" "sdhci_pci"];
    boot.initrd.kernelModules = [];
    boot.kernelModules = ["kvm-intel"];
    boot.extraModulePackages = [];

    hardware.bluetooth = {
      # enable = true;
    };

    hardware.graphics.enable = true;
    services.xserver.videoDrivers = ["nvidia" "modesetting"];
    hardware.nvidia = {
      open = false;
      modesetting.enable = true;
      nvidiaSettings = true;
      prime = {
        intelBusId = "PCI:0@0:2:0";
        nvidiaBusId = "PCI:1@0:0:0";
        offload.enable = true;
        offload.enableOffloadCmd = true;
      };
    };
    specialisation.prime-sync.configuration = {
      system.nixos.tags = ["prime-sync-mode"];
      hardware.nvidia.prime = {
        offload = {
          enable = lib.mkForce false;
          enableOffloadCmd = lib.mkForce false;
        };
        sync.enable = lib.mkForce true;
      };
    };

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/cfc3644e-1a81-4b45-b492-ba1a2d96ff85";
      fsType = "btrfs";
      options = ["subvol=@root"] ++ mountOpts;
    };

    fileSystems."/home" = {
      device = "/dev/disk/by-uuid/cfc3644e-1a81-4b45-b492-ba1a2d96ff85";
      fsType = "btrfs";
      options = ["subvol=@home"] ++ mountOpts;
    };

    fileSystems."/var/log" = {
      device = "/dev/disk/by-uuid/cfc3644e-1a81-4b45-b492-ba1a2d96ff85";
      fsType = "btrfs";
      options = ["subvol=@log"] ++ mountOpts;
    };

    fileSystems."/nix" = {
      device = "/dev/disk/by-uuid/cfc3644e-1a81-4b45-b492-ba1a2d96ff85";
      fsType = "btrfs";
      options = ["subvol=@nix"] ++ mountOpts;
    };

    fileSystems."/boot/efi" = {
      device = "/dev/disk/by-uuid/4B8D-2B16";
      fsType = "vfat";
      options = ["fmask=0022" "dmask=0022"];
    };

    fileSystems."/mnt/hdd-ext4" = {
      device = "/dev/disk/by-uuid/63802ddb-8f7f-4575-8c5f-d52a32e0199d";
      fsType = "ext4";
    };

    fileSystems."/mnt/hdd-ntfs" = {
      device = "/dev/disk/by-uuid/507C58524C28C058";
      fsType = "ntfs3";
      options = ["defaults" "noauto"];
    };

    nixpkgs.hostPlatform = "x86_64-linux";
  };
}
