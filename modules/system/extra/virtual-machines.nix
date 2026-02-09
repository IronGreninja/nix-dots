## vm's with qemu & virt-manager
{
  self,
  lib,
  ...
}: {
  flake.modules = lib.mkMerge [
    {
      nixos.virtual-machines = {pkgs, ...}: {
        virtualisation.libvirtd = {
          enable = true;
          qemu.vhostUserPackages = [pkgs.virtiofsd];
        };
        programs.virt-manager.enable = true;
      };
    }

    (self.factory.groupsToUsers ["libvirtd" "kvm"]
      ["igreninja"])
  ];
}
/*
https://discourse.nixos.org/t/virt-manager-cannot-find-virtiofsd/26752/2
*/

