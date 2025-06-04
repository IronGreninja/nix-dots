{
  wayland.windowManager.hyprland.settings = {
    monitor = ", preferred, auto, auto";

    general = {
      gaps_in = 5;
      gaps_out = 10;
      border_size = 2;
      allow_tearing = false;
      resize_on_border = false;
      layout = "dwindle";
    };

    decoration = {
      rounding = 10;
    };

    input = {
      kb_layout = "us";
      accel_profile = "flat";
      follow_mouse = 1;
      sensitivity = 0;
      touchpad.natural_scroll = true;
    };

    dwindle = {
      pseudotile = true; # Master switch for pseudotiling. Enabling is bound to $mainMod + P in keybinds
      preserve_split = true; # You probably want this
    };

    master.new_status = "master";

    # misc = {
    #   disable_hyprland_logo = true;
    #   force_default_wallpaper = 0;
    # };
  };
}
