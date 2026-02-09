{
  inputs,
  self,
  ...
}: let
in {
  flake.modules.nixos.nero = {
    config,
    lib,
    pkgs,
    ...
  }: let
  in {
    imports = with self.modules.nixos; [
      # Features
      grub
      sound
      virtual-machines
      virtual-cam
      containers
      gaming

      # Programs
      kdeplasma
      # hyprland
      wireshark

      # Services
    ];

    # programs.niri.enable = true;

    # programs.noisetorch.enable = true;

    services = {
    };

    # networking.firewall.interfaces."wg_asterion".allowedTCPPorts = [9999];
    networking.firewall.allowedTCPPorts = [
      # 2283 # immich
    ];
  };
}
