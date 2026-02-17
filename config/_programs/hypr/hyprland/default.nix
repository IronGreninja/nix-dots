{self, ...}: {
  flake.modules.nixos.hyprland = {
    programs.hyprland.enable = true;
    imports = with self.modules.nixos; [hyprlock];
  };

  flake.modules.homeManager.hyprland = {
    config,
    lib,
    pkgs,
    ...
  }: let
  in {
    imports = with self.modules.homeManager; [
      hypridle
      hyprlock
      hyprsunset

      kitty
      anyrun
      waybar

      # mako # service keeps running when logout from hyprland to plasma, so run with 'exec-once'
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
  };
}
