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
    wayland.windowManager.hyprland.enable = true;

    programs = {
      kitty.enable = true;
      waybar.enable = true;
      hyprlock.enable = true;
    };

    services = {
      mako.enable = true;
      hypridle.enable = true;
      hyprsunset.enable = true;
    };

    home.packages = with pkgs; [
      anyrun # launcher

      clipse # clipboard manager
      wl-clipboard

      hyprpicker # color-picker
      grimblast # screenshot
      # wlogout

      # Qt theming
      libsForQt5.qt5ct
      kdePackages.qt6ct
    ];
  };
}
