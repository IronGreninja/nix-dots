{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      # Ignore maximize requests from apps. You'll probably like this.
      "suppressevent maximize, class:.*"
      # Fix some dragging issues with XWayland
      "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"

      "float, class:^firefox$, title:^About.*$"
      "size 50% 50%, class:^firefox$, title:^File Upload$"
      "center, class:^firefox$, title:^File Upload$"

      "float, class:(clipse)"
      "size 976 656, class:(clipse)"
      "stayfocused, class:(clipse)"

      "float, class:^wlogout$"
      "fullscreen, class:^wlogout$"
      "noanim, class:^wlogout$"

      "float, class:^qalculate-(gtk|qt)$"

      "float, class:^pavucontrol$"
      "size 50% 50%, class:^pavucontrol$"

      "float, title:^nmtui$"
      "float, class:^nm-connection-editor$"
    ];
  };
}
