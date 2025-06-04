{pkgs, ...}: let
in {
  wayland.windowManager.hyprland = {
    xwayland.enable = true;
    systemd.enable = true;
    systemd.variables = ["--all"];
    settings = {
      "$mod" = "SUPER";

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
        "hyprsunset"
        "waybar"
      ];
    };
  };

  imports = [
    ./general.nix
    ./binds.nix
    ./windowrules.nix
  ];

  home.packages = with pkgs; [
    ## commented packages have module that gets conditionally enabled with hyprland
    hyprsunset
    libsForQt5.qt5ct
    qt6ct
    # kitty
    # waybar
    # swaylock # needs security.pam setup in OS
    # swayidle
    # hyprpicker
    # hyprpaper
    # cliphist
    # wl-clipboard
    # wl-clip-persist
    # wlsunset
    # rofi-wayland
    # mako
    # wlogout

    # basic utils
    # qalculate-gtk
    # mpv
    # imv
    # xfce.thunar # enabled in OS
    # zathura
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
