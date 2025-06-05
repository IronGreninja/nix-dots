{
  username,
  host,
  hostOptions,
  inputs,
  outputs,
  config,
  lib,
  pkgs,
  ...
}: let
in {
  # programs.hyprland.enable = true;
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = lib.mkForce "breeze";
  };
  # programs.noisetorch.enable = true;
  systemModules = {
    core.sound.enable = true;
  };

  hardware.bluetooth = {
    enable = true;
  };

  programs.steam = {
    enable = true;
  };
  programs.gamemode.enable = true;
  programs.gamescope.enable = true;
}
