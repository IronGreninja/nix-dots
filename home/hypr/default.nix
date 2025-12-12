{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.homeSettings.hyprland;
in {
  options.homeSettings.hyprland = {
    enable = lib.mkEnableOption "Full Setup Hyprland";
  };

  imports = [
    ./hyprland

    ./hypridle.nix
    ./hyprlock.nix
    ./hyprsunset.nix
  ];

  config = lib.mkIf (cfg.enable) {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        "$mod" = "SUPER";

        "$terminal" = "kitty";
        "$menu" = "anyrun";
      };
    };

    programs = {
      kitty.enable = true;
      waybar.enable = true;
      hyprlock.enable = true;
      anyrun.enable = true;
    };

    services = {
      mako.enable = true;
      hypridle.enable = true;
      hyprsunset.enable = true;
    };

    home.packages = with pkgs; [
      clipse # clipboard manager
      wl-clipboard

      hyprpicker # color-picker
      grimblast # screenshot
      hyprpaper
      # wlogout

      # Qt theming
      # kdePackages.qt6ct
      qt6ct-kde
      kdePackages.qtstyleplugin-kvantum

      # GTK theming
      nwg-look
    ];
  };
}
