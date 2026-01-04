{
  pkgs,
  lib,
  config,
  ...
}: let
in {
  services.mako = with config.lib.stylix.colors; {
    enable = true;
    settings = {
      font = "'JetBrainsMono Nerd Font' Normal 17";
      background-color = "#${base01}";
      border-color = "#${base0E}";
      border-radius = 5;
      border-size = 2;
      text-color = "#${base04}";
      layer = "overlay";
    };
  };
}
