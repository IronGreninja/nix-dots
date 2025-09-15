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
      "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
      # "col.active_border" = "rgba(00ff99ee) rgba(ff6633ee) 120deg";
      "col.inactive_border" = "rgba(595959aa)";
    };

    decoration = {
      rounding = 10;
    };

    input = {
      kb_layout = "us";
      accel_profile = "flat";
      follow_mouse = 1;
      sensitivity = 0;
      float_switch_override_focus = 0;
      touchpad.natural_scroll = true;
    };

    dwindle = {
      pseudotile = true; # Master switch for pseudotiling. Enabling is bound to $mainMod + P in keybinds
      preserve_split = true; # You probably want this
    };

    master.new_status = "master";

    cursor = {
      no_warps = true;
    };

    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      force_default_wallpaper = 0;
    };
  };
}
