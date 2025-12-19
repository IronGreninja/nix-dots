## Enable grub & set default theme
{
  pkgs,
  outputs,
  ...
}: let
in {
  boot.loader = {
    timeout = 5;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      gfxmodeEfi = "1920x1080";
      useOSProber = true;
      theme = "${outputs.packages.${pkgs.stdenv.hostPlatform.system}.grub-stylish-theme}/stylish";
    };
  };
}
