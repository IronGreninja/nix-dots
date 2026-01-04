{
  config,
  lib,
  pkgs,
  ...
}: let
in {
  imports = [
    ./config.nix

    ../hypridle.nix
    ../hyprlock.nix
    ../hyprsunset.nix

    ../../kitty.nix
    ../../anyrun
    ../../waybar

    ../../mako.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";

      "$terminal" = "kitty";
      "$menu" = "anyrun";
    };
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
}
