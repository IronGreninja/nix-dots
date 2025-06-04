{
  pkgs,
  lib,
  hostOptions,
  config,
  ...
}: let
in
  lib.mkIf (hostOptions.hyprland or false) {
    programs.zathura = {
      enable = true;
      options = {
        selection-clipboard = "clipboard";
      };
    };
  }
