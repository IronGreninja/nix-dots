{
  pkgs,
  lib,
  config,
  ...
}: let
in {
  wayland.windowManager.hyprland = {
    xwayland.enable = true;
    systemd.enable = true;
    systemd.variables = ["--all"];
    settings = {
      "$mod" = "SUPER";

      "$terminal" = "kitty";
      "$menu" = "anyrun";

      env = [
        "QT_AUTO_SCREEN_SCALE_FACTOR, 1"
        "QT_QPA_PLATFORM, wayland;xcb"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION, 1"
        "QT_QPA_PLATFORMTHEME, qt6ct"

        "XCURSOR_THEME, Breeze_Light"
        "XCURSOR_SIZE, 48"
        "HYPRCURSOR_SIZE, 48"
      ];

      exec-once = [
        "clipse -listen"
        "mako"
        "hyprpaper"
      ];
    };
  };

  imports = [
    ./general.nix
    ./binds.nix
    ./windowrules.nix
  ];

  ## XDG settings ##
  # xdg = {
  #   mimeApps = {
  #     enable = false;
  #     defaultApplications = {
  #       "inode/directory" = ["thunar.desktop"];
  #       "text/plain" = ["nvim.desktop"];
  #       "text/*" = ["nvim.desktop"];
  #       "text/html" = ["nvim.desktop"];
  #       "text/x-lua" = ["nvim.desktop"];
  #       "application/pdf" = ["org.pwmt.zathura.desktop"];
  #       "video/*" = ["mpv.desktop"];
  #       #"image/*" = [ "" ];
  #     };
  #   };
  # };
}
