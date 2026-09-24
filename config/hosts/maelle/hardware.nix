{inputs, ...}: {
  den.aspects.maelle.nixos = {config, ...}: {
    imports = [inputs.nixos-hardware.nixosModules.dell-latitude-7420];

    boot.initrd.availableKernelModules = ["xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc"];
    boot.initrd.kernelModules = [];
    boot.kernelModules = ["kvm-intel"];
    boot.extraModulePackages = with config.boot.kernelPackages; [
    ];
    boot.extraModprobeConfig = ''
    '';

    boot.initrd.luks.devices."cryptroot".device = "/dev/disk/by-uuid/97a86097-ea19-4cf2-8686-3b1d45584360";

    fileSystems = let
      mountOpts = ["compress=zstd" "noatime"];
    in {
      "/" = {
        device = "/dev/mapper/cryptroot";
        fsType = "btrfs";
        options = ["subvol=@root"] ++ mountOpts;
      };

      "/home" = {
        device = "/dev/mapper/cryptroot";
        fsType = "btrfs";
        options = ["subvol=@home"] ++ mountOpts;
      };

      "/nix" = {
        device = "/dev/mapper/cryptroot";
        fsType = "btrfs";
        options = ["subvol=@nix"] ++ mountOpts;
      };

      "/boot" = {
        device = "/dev/disk/by-label/EFI";
        fsType = "vfat";
        options = ["fmask=0022" "dmask=0022"];
      };

      "/mnt/ext-hdd" = {
        device = "/dev/disk/by-label/Backup";
        fsType = "ext4";
        options = ["noauto" "nofail" "user" "x-systemd.automount"];
      };
    };

    nixpkgs.hostPlatform = "x86_64-linux";
  };
}
