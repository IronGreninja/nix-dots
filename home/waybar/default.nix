{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [./config.nix];

  home.packages = with pkgs; [
    pulseaudio # gives pactl command
    pavucontrol
    # networkmanagerapplet # nm-connection-editor
  ];
}
