{
  pkgs,
  lib,
  config,
  ...
}:
lib.mkIf (config.wayland.windowManager.hyprland.enable) {
  xdg.configFile."anyrun/config.ron".source = ./config.ron;
  xdg.configFile."anyrun/style.css".source = ./style.css;
}
