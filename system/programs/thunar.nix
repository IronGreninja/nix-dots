## Install extra plugins & services by default when thunar is enabled
{
  lib,
  pkgs,
  config,
  ...
}:
lib.mkIf config.programs.thunar.enable {
  programs.thunar = {
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };
  programs.xfconf.enable = true; # enable saving thunar settings
  services.gvfs.enable = true; # mount, trash, etc in thunar
  services.tumbler.enable = true; # thumbnail suport for images
}
