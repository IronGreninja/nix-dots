{
  wayland.windowManager.hyprland.settings = {
    bind =
      # workspaces
      builtins.concatLists (builtins.genList (
          x: let
            ws = builtins.toString (x + 1); # 1..10
            n =
              if ws == "10"
              then "0"
              else ws; # 1..9 & 0
          in [
            "$mod, ${n}, workspace, ${ws}" # move to workspace
            "$mod SHIFT, ${n}, movetoworkspace, ${ws}" # move active window to workspace
            "$mod ALT, ${n}, movetoworkspacesilent, ${ws}" # same as before but silently
          ]
        )
        10)
      ++ [
        # Move focus with mainMod + arrow keys
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        # Scroll through existing workspaces with mod + scroll
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
        # Example special workspace (scratchpad)
        "$mod, S, togglespecialworkspace, magic"
        "$mod SHIFT, S, movetoworkspace, special:magic"

        # Window management
        "$mod + SHIFT, Q, killactive,"
        "$mod, V, togglefloating,"
        "$mod, J, togglesplit," # dwindle
        "$mod, P, pseudo," # dwindle

        "$mod + SHIFT, M, exit," # logout
      ]
      # Launch Apps
      ++ [
        "$mod, R, exec, $menu"
        "$mod, Return, exec, $terminal" # Terminal
      ];

    bindm = [
      # Move/resize windows with mainMod + LMB/RMB and dragging
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];

    bindel = [
      # Laptop multimedia keys for volume and LCD brightness
      ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
      ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
    ];

    bindl = [
      # Requires playerctl
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPause, exec, playerctl play-pause"
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"
    ];
  };
}
