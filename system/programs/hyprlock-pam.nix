{
  config,
  lib,
  ...
}:
lib.mkIf (config.programs.hyprland.enable) {
  security.pam.services.hyprlock = {};
}
