{
  services.hypridle = {
    systemdTarget = "hyprland-session.target";
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock"; # avoid starting multiple hyprlock instances
        before_sleep_cmd = "loginctl lock-session"; # lock before suspend
        after_sleep_cmd = "hyprctl dispatch dpms on"; # to avoid having to press a key twice to turn on the display
        # ignore_dbus_inhibit = false;
      };

      listener = [
        {
          timeout = 300; # 5min
          on-timeout = "loginctl lock-session"; # lock screen when timeout passed
        }
        {
          timeout = 330; # 5.5min
          on-timeout = "hyprctl dispatch dpms off"; # screen off when timeout passed
          on-resume = "hyprctl dispatch dpms on"; # screen on when activity is detected after timeout has fired
        }
        {
          timeout = 420; # 7min
          on-timeout = "systemctl suspend"; # suspend pc
        }
      ];
    };
  };
}
