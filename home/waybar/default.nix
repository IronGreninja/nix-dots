{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [./config.nix];

  config = lib.mkIf (config.programs.waybar.enable) {
    home.packages = with pkgs; [
      pulseaudio # gives pactl command
      pavucontrol
      # networkmanagerapplet # nm-connection-editor
    ];
  };
}
