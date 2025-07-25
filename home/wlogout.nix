{
  pkgs,
  config,
  hostOptions,
  lib,
  ...
}: let
  palette = config.colorScheme.palette;
  o = hostOptions;
  style =
    /*
    css
    */
    ''
      * {
        font-family: "CaskaydiaCove Nerd Font", FontAwesome, sans-serif;
        background-image: none;
        transition: 20ms;
      }
      window {
        background-color: rgba(12, 12, 12, 0.1);
      }
      button {
        color: #${palette.base05};
        font-size:20px;
        background-repeat: no-repeat;
        background-position: center;
        background-size: 25%;
        border-style: solid;
        background-color: rgba(12, 12, 12, 0.3);
        border: 3px solid #${palette.base05};
        box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
      }
      button:focus,
      button:active,
      button:hover {
        color: #${palette.base0E};
        background-color: rgba(12, 12, 12, 0.5);
        border: 3px solid #${palette.base0E};
      }
      #logout {
        margin: 10px;
        border-radius: 20px;
        background-image: image(url("icons/logout.png"));
      }
      #suspend {
        margin: 10px;
        border-radius: 20px;
        background-image: image(url("icons/suspend.png"));
      }
      #shutdown {
        margin: 10px;
        border-radius: 20px;
        background-image: image(url("icons/shutdown.png"));
      }
      #reboot {
        margin: 10px;
        border-radius: 20px;
        background-image: image(url("icons/reboot.png"));
      }
      #lock {
        margin: 10px;
        border-radius: 20px;
        background-image: image(url("icons/lock.png"));
      }
      #hibernate {
        margin: 10px;
        border-radius: 20px;
        background-image: image(url("icons/hibernate.png"));
      }
    '';
in
  lib.mkIf o.hyprland {
    programs.wlogout = {
      enable = true;
      layout = [
        {
          label = "shutdown";
          action = "sleep 1; systemctl poweroff";
          text = "Shutdown";
          keybind = "s";
        }
        {
          label = "reboot";
          action = "sleep 1; systemctl reboot";
          text = "Reboot";
          keybind = "r";
        }
        {
          label = "logout";
          action = "sleep 1; hyprctl dispatch exit";
          text = "Suspend";
          keybind = "u";
        }
        {
          label = "lock";
          action = "sleep 1; hyprlock";
          text = "Lock";
          keybind = "l";
        }
        # {
        #   label = "hibernate";
        #   action = "sleep 1; systemctl hibernate";
        #   text = "Hibernate";
        #   keybind = "h";
        # }
      ];
    };
  }
