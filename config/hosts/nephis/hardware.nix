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
    hardware.graphics.enable32Bit = true; # fixes some games
    services.xserver.videoDrivers = ["nvidia" "modesetting"];
    hardware.nvidia = {
      open = true;
      modesetting.enable = true;
      nvidiaSettings = true;
      prime = {
        intelBusId = "PCI:0@0:2:0";
        nvidiaBusId = "PCI:1@0:0:0";
        offload.enable = true;
        offload.enableOffloadCmd = true;
      };
    };

    fileSystems."/" = {
      device = "/dev/disk/by-label/ssd";
      fsType = "btrfs";
      options = ["subvol=@root"] ++ mountOpts;
    };

    fileSystems."/home" = {
      device = "/dev/disk/by-label/ssd";
      fsType = "btrfs";
      options = ["subvol=@home"] ++ mountOpts;
    };

    fileSystems."/var/log" = {
      device = "/dev/disk/by-label/ssd";
      fsType = "btrfs";
      options = ["subvol=@log"] ++ mountOpts;
    };

    fileSystems."/nix" = {
      device = "/dev/disk/by-label/ssd";
      fsType = "btrfs";
      options = ["subvol=@nix"] ++ mountOpts;
    };

    fileSystems."/boot/efi" = {
      device = "/dev/disk/by-label/EFI";
      fsType = "vfat";
      options = ["fmask=0022" "dmask=0022"];
    };

    fileSystems."/mnt/hdd" = {
      device = "/dev/disk/by-label/hdd";
      fsType = "ext4";
    };

    nixpkgs.hostPlatform = "x86_64-linux";
  };
}
