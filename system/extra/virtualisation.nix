## Expose custom option to install qemu & virt-manager
{
  pkgs,
  lib,
  config,
  username,
  ...
}:
with lib; let
  cfg = config.systemModules.extra.virtualisation;
in {
  options.systemModules.extra.virtualisation = {
    enable = mkEnableOption "virtualisation with qemu and virt-manager";
  };

  config = mkIf cfg.enable {
    virtualisation.libvirtd = {
      enable = true;
      qemu.vhostUserPackages = [pkgs.virtiofsd];
    };
    programs.virt-manager.enable = true;
    users.users.${username}.extraGroups = ["libvirtd" "kvm"];
  };
}
/*
https://discourse.nixos.org/t/virt-manager-cannot-find-virtiofsd/26752/2
*/

