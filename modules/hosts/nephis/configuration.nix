{self, ...}: {
  flake.modules.nixos.nephis = {
    lib,
    pkgs,
    ...
  }: let
  in {
    imports = with self.modules.nixos; [
      grub
      sound

      kdeplasma
    ];

    # programs.noisetorch.enable = true;

    hardware.bluetooth = {
      enable = true;
    };

    programs.steam = {
      enable = true;
    };
    programs.gamemode.enable = true;
    programs.gamescope.enable = true;
  };
}
