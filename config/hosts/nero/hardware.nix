{
  den.aspects.nero.nixos = {config, ...}: {
    boot.initrd.availableKernelModules = ["xhci_pci" "ehci_pci" "nvme" "usb_storage" "usbhid" "sd_mod"];
    boot.initrd.kernelModules = [];
    boot.kernelModules = ["kvm-intel"];
    boot.extraModulePackages = with config.boot.kernelPackages; [
    ];
    boot.extraModprobeConfig = ''
    '';

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/ee637313-ce0e-420a-82d0-9464a9ba2963";
      fsType = "ext4";
    };

    fileSystems."/boot/efi" = {
      device = "/dev/disk/by-uuid/3B9D-ED4E";
      fsType = "vfat";
      options = ["fmask=0022" "dmask=0022"];
    };

    fileSystems."/mnt/ext-hdd" = {
      device = "/dev/disk/by-label/Backup";
      fsType = "ext4";
      options = ["auto" "nofail" "user"];
    };

    environment.etc."crypttab".text = ''
      private_stash /dev/disk/by-uuid/89c1c461-917f-477d-b504-378357e3b07e none noauto
    '';

    fileSystems."/mnt/private" = {
      device = "/dev/mapper/private_stash";
      fsType = "ext4";
      options = ["noauto"];
    };

    nixpkgs.hostPlatform = "x86_64-linux";

    hardware.opentabletdriver.enable = true;
  };
}
