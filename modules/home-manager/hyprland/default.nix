{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.homeSettings.hyprland;
in
  with lib; {
    options.homeSettings.hyprland = {
      enable = mkEnableOption "Full setup hyprland";
      terminal = mkOption {
        type = types.enum ["kitty"];
        default = "kitty";
        description = "Default terminal app";
      };
      menu = mkOption {
        type = types.enum ["anyrun"];
        default = "anyrun";
        description = "App launcher";
      };
      # fileManager = mkOption {
      #   type = types.enum ["dolphin"];
      #   default = "dolphin";
      #   description = "Default file manager app";
      # };
    };

    config = mkIf (cfg.enable) {
      programs = {
        kitty.enable =
          if (cfg.terminal == "kitty")
          then true
          else false;
        waybar.enable = true;
      };
      home.packages = [
        (mkIf (cfg.menu == "anyrun") pkgs.anyrun)
      ];
      wayland.windowManager.hyprland = {
        enable = true;
        settings = {
          "$terminal" = cfg.terminal;
          "$menu" = cfg.menu;
        };
      };
    };
  }
